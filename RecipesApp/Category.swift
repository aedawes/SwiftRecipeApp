//
//  Category.swift
//  RecipesApp
//
//  Created by Emme Anais Dawes on 2023-12-13.
//
import Foundation
import SwiftData
import MarkdownUI

@Model
class Category {
    
    //MARK: Properties
    
    var name: String
    var isSelected: Bool
    @Relationship(inverse: \Recipe.categories) var recipes: Array<Recipe>
    
    
    //MARK: Initialization
    
    init(categoryName: String, recipes: Array<Recipe> = []) {
        self.name = categoryName
        self.isSelected = false
        self.recipes = recipes
    }
}

