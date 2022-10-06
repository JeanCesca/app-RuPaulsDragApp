//
//  API.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 11/08/22.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case urlError
    case serverError
    case decodingError
}

class DragManager {
    
    func fetchDrag(completion: @escaping (Result<[Profile], NetworkError>) -> Void ) {
        guard let url = URL(string: "http://www.nokeynoshade.party/api/seasons") else {
            completion(.failure(.urlError))
            return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return }
                
                do {
                    let decoder = JSONDecoder()
                    let profiles = try decoder.decode([Profile].self, from: data)
                    completion(.success(profiles))
                    
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string) else { return nil }
        
        var image: UIImage?
        
        do {
            let data = try Data(contentsOf: url, options: [])
            image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        return image
    }
}


