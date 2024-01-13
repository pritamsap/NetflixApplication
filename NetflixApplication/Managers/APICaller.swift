//
//  APICaller.swift
//  NetflixApplication
//
//  Created by pritam on 2024-01-12.
//

import Foundation

struct Constants {
    static let API_KEY = ConfigurationManager.shared.apiKey
    static let base_URL  = "https://api.themoviedb.org"
    static let GOOGLE_API_KEY  = ConfigurationManager.shared.GoogleApiKey
    static let google_base_URL = "https://youtube.googleapis.com/youtube/v3/search?"
}



enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let share  = APICaller()
    
    
    // Decoding the trending movies properties
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.base_URL)/3/trending/movie/day?api_key=\(Constants.API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    
    // Decoding the trending tv
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.base_URL)/3/trending/tv/day?api_key=\(Constants.API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    // Decoding upcoming Movies
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.base_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    // Decoding popular Movies
    func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.base_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    // Decoding Top Rated Movies
    func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.base_URL)/3/movie/upcoming?api_key=\(Constants.API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    // Decoding Discover Movies
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string:
                "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")
            
        else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        
    }
    
    // Search Movies and Tv Shows
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        
        // Formatted the query for the correct url
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else
        { return }
        
        guard let url = URL(string: "\(Constants.base_URL)/3/search/movie?query=\(query)&api_key=\(Constants.API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
        
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        // Formatted the query for the correct url
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else
        { return }
        
        guard let url = URL(string: "\(Constants.google_base_URL)q=\(query)&key=\(Constants.GOOGLE_API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                print(results)
            }catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    
}

