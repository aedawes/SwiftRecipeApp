//
//  RecipesAppApp.swift
//  RecipesApp
//
//  Created by Emme Anais Dawes on 2023-11-29.
//

import SwiftUI
import SwiftData

@main
struct MyRecipesApp: App {

    var body: some Scene {
        WindowGroup {
            RecipeHomeView()
        }
        .modelContainer(for: [Recipe.self])
    }
}
