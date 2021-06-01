//
//  MovieDetailViewController.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 26/04/2021.
//
import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var trailer: UIButton!
    @IBOutlet weak var category1: UILabel!
    @IBOutlet weak var category2: UILabel!
    @IBOutlet weak var category3: UILabel!
    @IBOutlet weak var category1View: UIView!
    @IBOutlet weak var category2View: UIView!
    @IBOutlet weak var category3View: UIView!
    
    let movie: Movie
    
    // Custom initializer
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    // Initializer by storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie.title
        originalTitle.text = movie.originalTitle
        releaseDate.text = movie.releaseDate
        overview.text = movie.overview
        
        if let duration = movie.runtime, let overview = movie.overview {
            let hours = duration/60
            let minutes = duration%60
            self.duration.text = "\(hours)h\(minutes)"
            self.overview.text = overview
        } else {
            print("No runtime.")
        }
        
        if let posterPath = movie.posterPath, let path = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")  {
            self.poster.downloaded(from: path)
        }
        
        if let backdropPath = movie.backdropPath, let path = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)") {
            self.image.downloaded(from: path)
        }
        
        if let categories = movie.genres {
            let maxCategories = 3
            if categories.count > maxCategories {
                category1.text = categories[0].name
                category2.text = categories[1].name
                category3.text = categories[2].name
            } else if categories.count >= maxCategories {
                category1.text = categories[0].name
                category2.text = categories[1].name
                category3View.isHidden = true
                
                category3View.backgroundColor = UIColor(white: 1, alpha: 1)
            } else {
                category1.text = categories[0].name
                category2View.isHidden = true
                category3View.isHidden = true
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openTrailer(_ sender: UIButton) {
        ApiConnection().getMovieVideos(completion: { (videos) in
            let trailer: String = videos.results[0].key
            if let url = URL(string: "https://www.youtube.com/watch?v=\(trailer)") {
                    UIApplication.shared.open(url)
            }
        }, movieId: movie.id)
    }
}

