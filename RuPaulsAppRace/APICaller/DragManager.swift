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

protocol DragManagerProtocol {
    func getAllSeasons(completion: @escaping (Result<[AllSeasons], NetworkError>) -> Void)
    func getAllDragsBySeason(seasonNumber: String, completion: @escaping (Result<[SingleSeason], NetworkError>) -> Void)
}

class DragManager: DragManagerProtocol {
    
    static let shared = DragManager()
    
    private init() {}
    
//    func loadWorldCup() {
//
//        if let fileURL = Bundle.main.url(forResource: "winners", withExtension: "json") {
//            do {
//                let jsonData = try! Data(contentsOf: fileURL)
//                worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func getAllSeasons(completion: @escaping (Result<[AllSeasons], NetworkError>) -> Void) {
        
        let seasonsPath = "http://www.nokeynoshade.party/api/seasons"
        
        guard let url = URL(string: seasonsPath) else {
            completion(.failure(.urlError))
            return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return }
                
                do {
                    let decoder = JSONDecoder()
                    let profiles = try decoder.decode([AllSeasons].self, from: data)
                    completion(.success(profiles))
                    
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func getAllDragsBySeason(seasonNumber: String, completion: @escaping (Result<[SingleSeason], NetworkError>) -> Void) {
        
        let seasonsPath = "https://www.nokeynoshade.party/api/seasons/\(seasonNumber)/queens"
        
        guard let url = URL(string: seasonsPath) else {
            completion(.failure(.urlError))
            return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return }
                
                do {
                    let decoder = JSONDecoder()
                    let profiles = try decoder.decode([SingleSeason].self, from: data)
                    completion(.success(profiles))
                    
                } catch let error {
                    completion(.failure(.decodingError))
                    print(error)
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


