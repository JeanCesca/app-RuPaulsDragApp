//
//  DragViewModel.swift
//  RuPaulsAppRace
//
//  Created by Jean Ricardo Cesca on 06/10/22.
//

import Foundation
import UIKit

struct AllSeasonsViewModel {
    let seasonNumber: String
    let seasonImage: String
    
    //Dependecy Injection
    init(with model: AllSeasons) {
        self.seasonNumber = model.seasonNumber
        self.seasonImage = model.image_url
    }
    
    func getSeasonNumber(number: String) -> String {
        return "Season \(self.seasonNumber)"
    }
}
