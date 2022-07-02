//
//  AlertView.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 01/07/22.
//

import UIKit

enum AlertType {
    case error
    case empty
}

class AlertView: UIView {
    
    //MARK:- Layout:-
    @IBOutlet private weak var iconImageview: UIImageView!
    @IBOutlet private weak var messageLable: UILabel!
    
    //MARK:- Init Func
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let _ =   self.instanceFromNib(name: "AlertView")
        loadFonts()
    }
}

extension AlertView {
    
    private func loadFonts(){
        self.messageLable.font = UIFont.fonts(name: .regular, size: .size_xl)
    }
    
    func loadAlert(_ type: AlertType = .error){
        switch type {
        case .error:
            self.messageLable.text = "Something went wrong !!"
            self.iconImageview.image = UIImage(named: "error")
        case .empty:
            self.messageLable.text = "No data found !!"
            self.iconImageview.image = UIImage(named: "empty")
        }
    }
    
}
