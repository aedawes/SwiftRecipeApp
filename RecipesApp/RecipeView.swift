//
//  RecipeView.swift
//  RecipeApp
//
//  Created by Emme Anais Dawes on 2023-11-29.
//

//MARK: Credit
//ChatGPT: "Can you show me how to use Date formatter to get the format sept 6, 2000". Modified given code to fit my project.

import SwiftUI
import SwiftData
import MarkdownUI

//MARK: File Contents
//RecipeView - View for the Recipe
//RecipeHeaderView - The header for the recipe to include name, author, date, favourite, delete, and edit
//CategoryTagView - Displays the different categories for the recipe
//RecipeInformationView - Displays the time, skill, and servings for the recipe
//MainSection - Main contents of the recipe (ingredients, directions, and notes)

struct RecipeView: View {

    //MARK: Properties
    
    @State private var showingSheet = false
    @State private var detailVisible = true
    
    let recipe: Recipe
    
    
    //MARK: Main View
    
    var body: some View {
        if detailVisible {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        RecipeHeaderView(detailVisible: $detailVisible, recipe: recipe)
                        CategoryTagView(categories: recipe.categories, isForm: false)
                        RecipeInformationView(recipe: recipe)
                        MainSection(text: "Ingredients", type: recipe.ingredients)
                        MainSection(text: "Directions", type: recipe.directions)
                        MainSection(text: "Notes", type: recipe.notes)
                    }
                }
                .padding()
            }
        } else {
            Text("Please select a recipe")
        }
    }
}

struct RecipeHeaderView: View {
    
    //MARK: Properties
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var recipes: [Recipe]
    
    @State private var showingSheet = false
    
    @Binding var detailVisible: Bool
    
    let recipe: Recipe
    
    
    //MARK: Main View
    
    var body: some View {
        VStack (spacing: 0){
            HStack {
                Text(recipe.title)
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                Image(systemName: recipe.isFavourite ? "heart.fill" : "heart")
                    .onTapGesture {
                        recipe.isFavourite.toggle()
                    }
                Spacer()
                Text(formattedDate())
                    .foregroundColor(Color(UIColor.darkGrey))
            }
            HStack {
                Text(recipe.author)
                    .font(.system(size: 20))
                    .foregroundColor(Color(UIColor.darkGrey))
                Spacer()
                Button(action: {
                    withAnimation(.easeIn(duration: RecipeConstants.animationDuration)) {
                        deleteRecipe()
                    }
                }) {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .frame(width: RecipeConstants.imageRatio , height: RecipeConstants.imageRatio)
                        .padding(.vertical, RecipeConstants.imageHorizontalPadding)
                        .padding(.horizontal, RecipeConstants.imageVerticalPadding)
                }
                .foregroundColor(Color(UIColor.white))
                .background(Color(UIColor.pink))
                .cornerRadius(RecipeConstants.cornerRadius)
                
                Button(action: {
                    showingSheet.toggle()
                }) {
                    Image(systemName: "applepencil.gen1")
                        .resizable()
                        .frame(width: RecipeConstants.imageRatio, height: RecipeConstants.imageRatio)
                        .padding(.vertical, RecipeConstants.imageHorizontalPadding)
                        .padding(.horizontal, RecipeConstants.imageVerticalPadding)
                }
                .foregroundColor(Color(UIColor.white))
                .background(Color(UIColor.green))
                .cornerRadius(RecipeConstants.cornerRadius)
                .sheet(isPresented: $showingSheet) {
                    FormView(recipe: recipe)
                }
            }
            .padding(.vertical, 5)
        }
    }
    
    
    //MARK: Methods
                     
    private func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
                    
        return dateFormatter.string(from: recipe.date)
    }
                     
    private func deleteRecipe() {
        //ChatGPT: Show me an example of using firstIndex(where:)  in Swift
        guard let recipeIndex = recipes.firstIndex(where: { $0.title == recipe.title }) else {
            return
        }
        
        modelContext.delete(recipes[recipeIndex])
        detailVisible = false
    }
    
    //MARK: Constants
    
    private struct RecipeConstants {
        static let cornerRadius: CGFloat = 10
        static let imageRatio: CGFloat = 20
        static let imageHorizontalPadding: CGFloat = 5
        static let imageVerticalPadding: CGFloat = 10
        static let animationDuration = 0.3
    }
}

struct CategoryTagView: View {
    
    //MARK: Properties
    
    let categories: Array<Category>
    let isForm: Bool
    
    
    //MARK: Main View
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(isForm ? UIColor.lightGreen : UIColor.green))
                .cornerRadius(5)
            HStack {
                Text(categoryText())
                    .foregroundColor(Color(isForm ? UIColor.darkGrey : UIColor.white))
                Spacer()
            }
            .padding(10)
        }
    }
    
    
    //MARK: Methods
    
    private func categoryText() -> String {
        categories.isEmpty ? "This recipe is not in a category" : categories.map {$0.name}.joined(separator: ", ")
    }
}

struct RecipeInformationView: View {
    
    //MARK: Properties
    
    let recipe: Recipe
    
    var minutes: String {
        if recipe.minutes < 10 {
            "0" + String(recipe.minutes)
        } else {
            String(recipe.minutes)
        }
    }
    
    
    //MARK: Main View
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.lightGreen))
                .cornerRadius(5)
            HStack {
                Image(systemName: "clock.fill")
                Text("\(recipe.hours)" + ":" + minutes)
                    .foregroundColor(Color(UIColor.darkGrey))
                Spacer()
                Image(systemName: "arrowshape.up.fill")
                Text(recipe.skillLevel)
                    .foregroundColor(Color(UIColor.darkGrey))
                Spacer()
                Image(systemName: "fork.knife")
                Text("\(String(recipe.servingSize))")
                    .foregroundColor(Color(UIColor.darkGrey))
            }
            .padding(10)
            .padding(.trailing, 30)
        }
    }
}

struct MainSection: View {
    
    //MARK: Properties
    
    let text: String
    let type: String
    
    
    //MARK: Main View
    
    var body: some View {
        ZStack (alignment: .leading){
            Rectangle()
                .foregroundColor(Color(UIColor.lightGray))
                .cornerRadius(10)
            VStack (alignment: .leading) {
                Text(text)
                    .fontWeight(.semibold)
                    .font(.system(size: 25))
                    .padding(.bottom, 1)
                Markdown(type)
                    .padding(.leading, 20)
            }
            .padding(15)
            .padding(.bottom, 10)
        }
    }
}
