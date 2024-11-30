//
//  NetworkManager.swift
//  MyRecipesApp
//
//  Created by Aviad Sabag on 28/11/2024.
//

import Foundation

enum NetworkManagerError: Error {
    case invalidURL
    case noData
    case decodingError
    case invalidStatusCode(Int)
}


final class NetworkManager {
    
    static let shared = NetworkManager()

    
    func get<T: Codable>(from url: String, completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(NetworkManagerError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkManagerError.noData))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkManagerError.noData))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkManagerError.invalidStatusCode(httpResponse.statusCode)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    
    public func getRecipeImage(recipe: Recipe, completion: @escaping (Result<Data, Error>) -> Void
    ) {
        if let imgUrl = recipe.thumb {
            guard let url = URL(string: imgUrl) else { return }
            
            let task = URLSession.shared.dataTask(with: url) {data, _ , error in
                guard let data = data, error == nil else {
                    return
                }
                
                completion(.success(data))
            }
            
            task.resume()
            
        }
    }
    
    
}
