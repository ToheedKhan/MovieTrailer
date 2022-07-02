//
//  MovieTableCell.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit


class MovieTableCell: UITableViewCell {

    //MARK:- Layout:-

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var rate: UILabel!
    
    @IBOutlet weak var voteCount: UILabel!
    
    @IBOutlet weak var popularity: UILabel!
    
    //Text Labels
    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var voteCountLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    //MARK:- Life Cycle:-
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        loadFonts()
//    }
    
    //MARK:- View Model Movie cell
    var cellViewModel: MovieCellViewModel? {
        didSet {
            self.setup()
           
//            DispatchQueue.global(qos: .userInteractive).async { [self] in
            DispatchQueue.main.async {
                self.loadFonts()
                self.applyColors()
            }
            
        }
    }
    
    //MARK:- To Load Fonts
    private func loadFonts(){
        self.movieTitle.font = UIFont.fonts(name: .semiBold, size: .size_2xl)
        self.releaseDate.font = UIFont.fonts(name: .meduim, size: .size_l)
        self.rate.font = UIFont.fonts(name: .meduim, size: .size_l)
        self.voteCount.font = UIFont.fonts(name: .meduim, size: .size_l)
        self.popularity.font = UIFont.fonts(name: .meduim, size: .size_l)
        
        self.popularityLabel.font = UIFont.fonts(name: .meduim, size: .size_l)
        self.rateLabel.font = UIFont.fonts(name: .meduim, size: .size_l)
        self.voteCount.font = UIFont.fonts(name: .meduim, size: .size_l)
    }

    private func applyColors(){
        self.movieTitle.textColor = DesignSystem.Colors.blueColor.color
        self.releaseDate.textColor = DesignSystem.Colors.darkLine.color
        self.rate.textColor = DesignSystem.Colors.primary.color
        self.voteCount.textColor = DesignSystem.Colors.darkLine.color
        self.popularity.textColor = DesignSystem.Colors.darkLine.color
        
        self.popularityLabel.textColor = DesignSystem.Colors.darkLine.color
        self.voteCountLabel.textColor = DesignSystem.Colors.darkLine.color
        self.rateLabel.textColor = DesignSystem.Colors.primary.color
        
    }
}

//MARK:- Network:-
extension MovieTableCell {
    
    //MARK:- Setup & Load Data
    fileprivate func setup(){
        posterImageView.loadImage(urlName: cellViewModel?.posterImageUrl)
        posterImageView.loadImage(urlName: cellViewModel?.posterImageUrl)
        movieTitle.text = cellViewModel?.movieTitle
        releaseDate.text = cellViewModel?.releaseDate
        rate.text = cellViewModel?.rate
        voteCount.text = cellViewModel?.voteCount
        popularity.text = cellViewModel?.popularity
    }
}
