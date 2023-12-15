//
//  Recipe.swift
//  RecipesApp
//
//  Created by Emme Anais Dawes on 2023-12-07.
//

import Foundation
import SwiftData
import MarkdownUI

@Model
class Recipe {
    
    //MARK: Properties
    
    var title: String
    var author: String
    var isFavourite: Bool
    var date: Date
    var categories: Array<Category>
    var hours: Int
    var minutes: Int
    var skillLevel: String
    var servingSize: Int
    var ingredients: String
    var directions: String
    var notes: String
    
    enum SkillLevel: String, CaseIterable {
        case Beginner
        case Intermediate
        case Advanced
    }
    
    //MARK: Initialization
    
    init(title: String, author: String, isFavourite: Bool = false, date: Date, categories: Array<Category>, hours: Int, minutes: Int, skillLevel: SkillLevel, servingSize: Int, ingredients: String, directions: String, notes: String) {
        self.title = title
        self.author = author
        self.isFavourite = isFavourite
        self.date = date
        self.categories = categories
        self.hours = hours
        self.minutes = minutes
        self.skillLevel = skillLevel.rawValue
        self.servingSize = servingSize
        self.ingredients = ingredients
        self.directions = directions
        self.notes = notes
    }
}
