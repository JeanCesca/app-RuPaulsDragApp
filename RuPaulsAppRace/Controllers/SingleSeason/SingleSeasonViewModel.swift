//
//  SingleSeasonViewModel.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 07/10/22.
//

import Foundation
import UIKit

struct SingleSeasonViewModel {
    let name: String
    let winner: Bool
    let image_url: String
    let quote: String
    
    init(with model: SingleSeason) {
        self.name = model.name
        self.winner = model.winner
        self.image_url = model.image_url ?? ""
        self.quote = model.quote ?? "*no quote found*"
    }
    
    func getWinner(winner: Bool) -> String {
        switch winner {
        case true:
            return "* WINNER * \(self.name)"
        case false:
            return "\(self.name)"
        }
    }
}
