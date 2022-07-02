//
//  NetworkService.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import Foundation

protocol NetworkServiceProtocol {
    func sendRequest<SuccessModel: Decodable>(
        urlRequest: URLRequest,
        successModel: SuccessModel.Type,
        completion: @escaping (RequestResult<SuccessModel>) -> Void
    )
}

class NetworkService {
    
    private let urlSession: URLSession
    
    required init(session: URLSession = URLSession.shared) {
        urlSession = session
    }
    
    private func validateErrors(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        if let error = error {
            return error
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return URLError(.badServerResponse)
        }
        switch statusCode {
        case StatusCode.okey.rawValue:
            return nil
        case StatusCode.badRequest.rawValue:
            return NetworkErrors.badRequest
        default:
            break
        }
        return nil
    }
    
    private func transformFromJSON<Model: Decodable>(
        data: Data?,
        objectType: Model.Type
    ) -> Model? {
        guard let data = data else {return nil}
        return try? JSONDecoder().decode(Model.self, from: data)
    }
    
    //MARK:- NetworkServiceProtocol
}

extension NetworkService: NetworkServiceProtocol {
    func sendRequest<SuccessModel: Decodable>(
        urlRequest: URLRequest,
        successModel: SuccessModel.Type,
        completion: @escaping (RequestResult<SuccessModel>) -> Void
    ) {
        
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {
                debugPrint("Your class is dead")
                return
            }
            if let error = self.validateErrors(data: data, response: response, error: error) {
                if case NetworkErrors.unauthorized = error {
                    
                } else if case NetworkErrors.badRequest = error {
                    if let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                        completion(.badRequest(model))
                    }
                } else {
                    completion(.failure("Check you JSON MODEL"))
                }
            } else if let model = self.transformFromJSON(data: data, objectType: successModel) {
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } else {
                completion(.failure("Something went wrong!!!"))
            }
        }.resume()
    }
}
