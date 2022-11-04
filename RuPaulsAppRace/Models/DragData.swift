//
//  DragData.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 06/10/22.
//

import Foundation

//All Seasons
struct AllSeasons: Codable {
    let id: Int
    let seasonNumber: String
    let image_url: String
//    let queens: [Queens]
}

//struct Queens: Codable {
//    let id: Int
//    let name: String
//    let place: Int
//}

//Single Season
struct SingleSeason: Codable {
    let id: Int
    let name: String
    let winner: Bool
    let image_url: String?
    let quote: String?
}
