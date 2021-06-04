//
//  TopMoviesTableViewController.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 04/06/2021.
//

import UIKit

class TopMoviesTableViewController: UITableViewController {
    
    //init
    private var topMovies: TopMovies = TopMovies(page: 1, results: [], totalResults: 4, totalPages: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Configure variable - Fetch categories
        ApiConnection().getTopMovies { (movies) in
            self.topMovies = movies
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topMovies.results.count
    }
    
    func setupViews(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: MovieCell.reuseId)
            
        tableView.rowHeight = 80;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseId, for: indexPath) as! MovieCell
        
        // Get current movie
        let movie = topMovies.results[indexPath.row]
        
        // Configure the cell
        cell.titleLabel.text = movie.title
        cell.subtitleLabel.text = movie.originalTitle
        cell.dateLabel.text = movie.releaseDate
        
        // If the movie has a poster path, that his URL isn't nil and that our cell poster isn't null neither
        if let posterPath = movie.posterPath, let path = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"), let poster = cell.poster {
            poster.downloaded(from: path)
        } else {
            print("No images found.")
        }
        
        return cell
    }

}
