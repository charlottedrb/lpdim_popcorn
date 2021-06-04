//
//  ApiConnection.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 27/05/2021.
//

import Foundation
import UIKit

class ApiConnection {
    private var key: String = "6278f7e2ced32224c2ccfd711510a660"
    
    public func getCategories(completion: @escaping (_ categories: Categories) -> () ) {
        let urlCategoriesString: String = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(key)"
        
        // Check that URL conversion doesn't return nil
        guard let urlCategories = URL(string: urlCategoriesString) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlCategories, completionHandler: {
            data, response, error in
            // Unwrap variable
            guard let data = data, error == nil else {
                return
            }
        
            // Init JSON Decode object and decode json data into Category object
            do {
                let categories: Categories = try JSONDecoder().decode(Categories.self, from: data)
                // Place it in main thread - Force call in main thread
                DispatchQueue.main.async{
                    completion(categories)
                }
            } catch {
                print("Failed to decode with error : \(error)")
            }
        }).resume()
    }
    
    public func getMoviesByCategories(completion: @escaping (_ movies: Movies) -> (), categoryId: Int){
        let urlMoviesString: String = "https://api.themoviedb.org/3/discover/movie?api_key=\(key)&with_genres=\(categoryId)"
        
        guard let urlMovies = URL(string: urlMoviesString) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlMovies, completionHandler: {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Init JSON Decode object and decode json data into Movies object
            do {
                
                let movies: Movies = try JSONDecoder().decode(Movies.self, from: data)
                // Place it in main thread - Force call in main thread
                DispatchQueue.main.async{
                    completion(movies)
                }
            } catch {
                print("Failed to decode with error : \(error)")
            }
            
            
        }).resume()
    }
    
    public func getMovieDetails(completion: @escaping (_ movies: Movie) -> (), movieId: Int){
        let urlMovieString: String = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(key)"
        
        guard let urlMovie = URL(string: urlMovieString) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlMovie, completionHandler: {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Init JSON Decode object and decode json data into Movie object
            
            do {
                let movie: Movie = try JSONDecoder().decode(Movie.self, from: data)
                // Place it in main thread - Force call in main thread
                DispatchQueue.main.async{
                    completion(movie)
                }
            } catch {
                print("Failed to decode with error : \(error)")
            }
        }).resume()
    }
    
    public func getMovieVideos(completion: @escaping (_ videos: Videos) -> (), movieId: Int){
        let urlVideosString: String = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(key)"
        
        guard let urlVideos = URL(string: urlVideosString) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlVideos, completionHandler: {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Init JSON Decode object and decode json data into Videos object
            
            do {
                let videos: Videos = try JSONDecoder().decode(Videos.self, from: data)
                // Place it in main thread - Force call in main thread
                DispatchQueue.main.async{
                    print(videos)
                    completion(videos)
                }
            } catch {
                print("Failed to decode with error : \(error)")
            }
        }).resume()
    }

    public func getTopMovies(completion: @escaping (_ movies: TopMovies) -> ()) {
        let urlTopMoviesString: String = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(key)"
        
        guard let urlTopMovies = URL(string: urlTopMoviesString) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlTopMovies, completionHandler: {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Init JSON Decode object and decode json data into TopMovies object
            
            do {
                let topMovies: TopMovies = try JSONDecoder().decode(TopMovies.self, from: data)
                // Place it in main thread - Force call in main thread
                DispatchQueue.main.async{
                    //print(topMovies)
                    completion(topMovies)
                }
            } catch {
                print("Failed to decode with error : \(error)")
            }
        }).resume()
    }
    
    public func getTopActors(completion: @escaping(_ movies: TopActors) -> ()) {
        let urlTopActorsString: String = "https://api.themoviedb.org/3/person/popular?api_key=\(key)"
        
        guard let urlTopActors = URL(string: urlTopActorsString) else {
            return
        }
        
        URLSession.shared.dataTask(with: urlTopActors, completionHandler: {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Init JSON Decode object and decode json data into TopActors object
            
            do {
                let topActors: TopActors = try JSONDecoder().decode(TopActors.self, from: data)
                // Place it in main thread - Force call in main thread
                DispatchQueue.main.async{
                    print(topActors)
                    completion(topActors)
                }
            } catch {
                print("Failed to decode with error : \(error)")
            }
        }).resume()
    }
}
