//
//  Item.swift
//  RecipesApp
//
//  Created by Emme Anais Dawes on 2023-11-29.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
