//
//  MovieViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

class MovieListViewController: UIViewController {
    
    //MARK:- Layout:-
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alertView: AlertView!
    
    //MARK:- Variable & Constants:
    lazy var viewModel: MovieListViewModel  = {
        return MovieListViewModel()
    }()
    
    let refreshControl = UIRefreshControl()
    var movies: [MovieListViewModel]?
    
    //MARK:- Life Cycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
        viewModel.getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        self.navigationItem.title = "Movies"
    }
    
    //MARK:- Refresh Update
    @objc func refresh(){
        viewModel.isFetch = true
        viewModel.getMovies()
    }
    
}

//MARK:- Setup View Model
extension MovieListViewController {
    
    func setupViewModel() {
        viewModel.error = { [weak self] error in
            guard !error.isEmpty else {
                self?.alertView.isHidden = true
                return
            }
            self?.showAlert(.error)
        }
        
        viewModel.loading = { isLoading in
            guard isLoading else{
                LoadingIndicator.shared.hide()
                return
            }
            LoadingIndicator.shared.show(for: self.view)
        }
        
        viewModel.isRefresh = { [weak self] (isRefresh) in
            guard isRefresh else {
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
                return
            }
        }
        viewModel.moviesList = { [weak self] list in
            guard !list.isEmpty else {
                self?.showAlert(.empty)
                return
            }
            self?.alertView.isHidden = true
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func showAlert(_ type: AlertType = .error){
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.alertView.loadAlert( type)
            self.alertView.isHidden = false
        }
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : AppTheme.darkishPink ?? UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : AppTheme.darkishPink ?? UIColor.black]
        navigationController?.navigationBar.tintColor = AppTheme.darkishPink
    }
}

//MARK:- Table View Data Source
extension MovieListViewController: UITableViewDataSource {
    
    fileprivate func setupTableView(){
        self.tableView.isHidden = false
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.tableView.register(cell: MovieTableCell.self)
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeue() as MovieTableCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell") as! MovieTableCell
        cell.cellViewModel = viewModel.cellViewModels[indexPath.row]
        return cell
    }
    
}

//MARK:- Table View Delegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UIDevice.current.userInterfaceIdiom == .pad) { return 170 }
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- Navigation

extension MovieListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            if let destinationViewController = segue.destination as? MovieDetailViewController
            {
                let indexPath = self.tableView.indexPathForSelectedRow!
                destinationViewController.viewModel = MovieDetailViewModel(movie: viewModel.cellViewModels[indexPath.row])
            }
        }
    }
}
