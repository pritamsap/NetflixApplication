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
}



enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let share  = APICaller()
    
    
    // Decoding the trending movies properties
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.base_URL)/3/trending/all/day?api_key=\(Constants.API_KEY)")
        else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

