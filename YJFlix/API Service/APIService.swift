//
//  APIService.swift
//  YJFlix
//
//  Created by Yashraj on 10/02/26.
//

import Foundation

class APIService {
    let urlString = "https://api.tvmaze.com/shows"

    func fetchData(page: Int, completion: @escaping (Result<[Show], Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Error check
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }

            //Data check
            guard let data = data else {
                print("Error:", error)
                return
            }
            //Decode API JSON
            do {
                let shows = try JSONDecoder().decode([Show].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(shows))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
