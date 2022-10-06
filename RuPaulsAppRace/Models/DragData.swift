//
//  DragData.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 06/10/22.
//

import Foundation
import UIKit


struct Profile: Codable {
    let id: Int
    let seasonNumber: String
    let image_url: String
    let queens: [Queens]
}

struct Queens: Codable {
    let id: Int
    let name: String
    let place: Int
}
