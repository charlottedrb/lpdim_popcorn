//
//  MoviesViewController.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 26/04/2021.
//

import UIKit

class MoviesViewController: UITableViewController {
    
    var categoryId: Int = 0
    var categoryName: String? = nil
    
    //init
    private var movies: Movies = Movies(page: 1, results: [], totalPages: 1, totalResults: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Configure variable - Fetch categories
        ApiConnection().getMoviesByCategories(completion: { (movies) in
            self.movies = movies
            self.tableView.reloadData()
        }, categoryId: categoryId)
        
        if let name = categoryName {
            self.title = name
        }
    }
    
    func setupViews(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.reuseId)
        	
        tableView.rowHeight = 80;
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return movies.count
        return movies.results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseId, for: indexPath) as! MovieCell
        
        let movie = movies.results[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.subtitleLabel.text = movie.originalTitle
        cell.dateLabel.text = movie.releaseDate
        
        if let posterPath = movie.posterPath, let path = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"), let poster = cell.poster {
            poster.downloaded(from: path)
        } else {
            print("No images found.")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //effet de mise en avant
        tableView.deselectRow(at: indexPath, animated: true)
        
        ApiConnection().getMovieDetails(completion: { (movie) in
            let controller : MovieDetailViewController = MovieDetailViewController(movie: movie)
            self.present(controller, animated: true)
        }, movieId: movies.results[indexPath.row].id)
    }
}

// MARK: -UIImageView Extension

// Extend UIImageView class for image download
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
