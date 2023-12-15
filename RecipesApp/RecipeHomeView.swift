//
//  ContentView.swift
//  RecipeApp
//
//  Created by Emme Anais Dawes on 2023-11-28.
//

//MARK: Credit
//Adapted some code for learning how to use State variables from hackingwithswift.com

import SwiftUI
import SwiftData

//MARK: File Contents
//RecipeHomeView - View for the drawer that lists all recipes
//SearchBarView - View for the search bar

struct RecipeHomeView: View {
    
    //MARK: Properties
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var recipes: Array<Recipe>
    @Query private var categories: Array<Category>
    
    @State private var showingSheet = false
    @State private var recipeExists: String?
    @State private var selectedFilter: Filter = .all
    @State private var searchText = ""
    
    enum Filter: String {
        case all = "All"
        case categories = "Categories"
        case favourites = "Favorites"
        case search = "Search"
    }

    
    //MARK: Main View
    
    var body: some View {
        NavigationSplitView {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    SearchBarView(searchText: $searchText, selectedFilter: $selectedFilter)
                        .padding(.top, 10)
                    FilterButtonsView(searchText: $searchText, selectedFilter: $selectedFilter, geometryWidth: geometry.size.width)
                    ListView(selectedFilter: $selectedFilter, geometryWidth: geometry.size.width, recipes: recipes, categories: categories, searchString: searchText)
                }
                .sheet(isPresented: $showingSheet) {
                    FormView(recipe: nil)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Recipes")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .aspectRatio(10/3, contentMode: .fit)
                    }
                    ToolbarItem {
                            Button(action: initializeRecipes) {
                                Image(systemName: "pencil.and.scribble")
                                    .foregroundColor(Color(UIColor.darkGrey))
                            }
                    }
                    ToolbarItem {
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 10 , height: 10)
                                Text("recipe")
                                    .font(.system(size: 18))
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical, 5)
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 20)
                        .foregroundColor(Color(UIColor.white))
                        .background(Color(UIColor.green))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
        } detail: {
            Text("Select a Recipe")
        }
    }
    
    
    //MARK: Methods
    
    private func initializeRecipes() {
        for recipe in sampleRecipes {
            modelContext.insert(recipe)
            if recipe.title == "Lebkuchengewürz" {
                recipe.categories = sampleLebkuchengewürzCategories
            } else {
                recipe.categories = samplePfeffernüsseCategories
            }
        }
    }
}

struct SearchBarView: View {
    
    //MARK: Properties
    
    @Binding var searchText: String
    @Binding var selectedFilter: RecipeHomeView.Filter
    
    //MARK: Main View
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.grey))
                .cornerRadius(30)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor.darkGrey))
                TextField(
                    "Search Recipes",
                    text: $searchText
                )
                .foregroundColor(Color(UIColor.mediumGrey))
            }
            .padding(.horizontal, 15)
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.3)) {
                    selectedFilter = RecipeHomeView.Filter.search
                }
            }
        }
        .frame(height: 50)
    }
}
