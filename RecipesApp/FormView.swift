//
//  FormView.swift
//  RecipesApp
//
//  Created by Emme Anais Dawes on 2023-12-04.
//

import SwiftUI
import SwiftData

//MARK: File Contents
//FormView - Overall view for the form
//FormSectionTextView - View for the headers for each form section
//FormButtonView - View for buttons for the form
//TextInputView - View for fields for entering standard text
//MarkdownView - View for the markdown fields

struct FormView: View {
    
    //MARK: Properties
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query private var categories: Array<Category>
    
    @State private var showingSheet = false
    @State var recipeNameInput: String = ""
    @State var authorNameInput: String = ""
    @State var dateInput: Date = Date()
    @State var categoriesInput: Array<Category> = []
    @State var hoursInput: Int = 0
    @State var minutesInput: Int = 0
    @State var skillLevelInput: Recipe.SkillLevel = .Beginner
    @State var servingSizeInput: Int = 0
    @State var ingredientsInput: String = ""
    @State var directionsInput: String = ""
    @State var notesInput: String = ""
    
    var recipe: Recipe?
    
    
    //MARK: Initialization
    
    init(recipe: Recipe?) {
        self.recipe = recipe
    }
    
    
    //MARK: Main View
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    
                    //Title, author, and date inputs
                    VStack {
                        TextInputView(text: $recipeNameInput, placeholder: "recipe name")
                        TextInputView(text: $authorNameInput, placeholder: "author name")
                        DatePicker("Recipe creation date", selection: $dateInput, displayedComponents: .date)
                            .foregroundColor(Color(UIColor.darkGrey))
                    }
                    
                    //Choose a category
                    VStack(alignment: .leading) {
                        FormSectionTextView(text: "Categories")
                        VStack {
                            CategoryTagView(categories: categoriesInput, isForm: true)
                            FormButtonView(
                                text: "Select categories",
                                action: selectAssociatedCategories,
                                secondaryAction: { showingSheet.toggle() },
                                isAdding: true,
                                cornerRadius: FormConstants.cornerRadius)
                                .sheet(isPresented: $showingSheet) {
                                    CategoryView(selectedCategoriesInput: $categoriesInput, categories: categories)
                            }
                        }
                    }
                    
                    //Recipe Information (time, skill, servings)
                    VStack(alignment: .leading) {
                        FormSectionTextView(text: "Recipe Information")
                        VStack {
                            
                            //Time input
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(UIColor.grey))
                                    .cornerRadius(FormConstants.cornerRadius)
                                HStack {
                                    Text("Total time")
                                        .foregroundColor(Color(UIColor.darkGrey))
                                    Spacer()
                                    Picker("hours", selection: $hoursInput) {
                                        ForEach(0..<72, id: \.self) { index in
                                            Text("\(index) hours")
                                        }
                                    }
                                    Picker("minutes", selection: $minutesInput) {
                                        ForEach(0..<60, id: \.self) { index in
                                            Text("\(index) minutes")
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, FormConstants.verticalPickerPadding)
                            }
                            
                            //Skill level input
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(UIColor.grey))
                                    .cornerRadius(FormConstants.cornerRadius)
                                HStack {
                                    Text("Skill level")
                                        .foregroundColor(Color(UIColor.darkGrey))
                                    Spacer()
                                    Picker("Skilllevel", selection: $skillLevelInput) {
                                        ForEach(Recipe.SkillLevel.allCases, id: \.self) {
                                            Text($0.rawValue)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, FormConstants.verticalPickerPadding)
                            }
                            
                            //Serving Size Picker
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(UIColor.grey))
                                    .cornerRadius(FormConstants.cornerRadius)
                                HStack {
                                    Text("Servings")
                                        .foregroundColor(Color(UIColor.darkGrey))
                                    Spacer()
                                    Picker("servings", selection: $servingSizeInput) {
                                        ForEach(0..<100, id: \.self) { index in
                                            Text("\(index)")
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, FormConstants.verticalPickerPadding)
                            }
                        }
                    }
                    
                    //Ingredients list
                    MarkdownView(text: $ingredientsInput, sectionText: "Ingredients", placeholderText: "add your bulleted ingredient list")
                    
                    //Directions list
                    MarkdownView(text: $directionsInput, sectionText: "Directions", placeholderText: "add your numbered directions")
                    
                    //Notes list
                    MarkdownView(text: $notesInput, sectionText: "Notes", placeholderText: "add your bulleted notes")
                    
                    //Add a done button
                    FormButtonView(text: "Save Recipe", action: saveRecipe, secondaryAction: nil, isAdding: true, cornerRadius: FormConstants.cornerRadius)
                }
            }
        }
        .padding()
        .onAppear {
            if let recipe {
                selectAssociatedCategories()
                
                recipeNameInput = recipe.title
                authorNameInput = recipe.author
                hoursInput = recipe.hours
                minutesInput = recipe.minutes
                servingSizeInput = recipe.servingSize
                ingredientsInput = recipe.ingredients
                directionsInput = recipe.directions
                notesInput = recipe.notes
                
                switch recipe.skillLevel {
                    case "beginner":
                        skillLevelInput = .Beginner
                    case "intermediate":
                        skillLevelInput = .Intermediate
                    case "advanced":
                        skillLevelInput = .Advanced
                    default:
                        skillLevelInput = .Beginner
                }
            } else {
                clearSelectForAllCategories()
            }
        }
    }
    
    
    //MARK: Methods
    private func selectAssociatedCategories() {
        if let recipe {
            for index in recipe.categories.indices {
                recipe.categories[index].isSelected = true
            }
        }
    }
    
    private func clearSelectForAllCategories() {
        for index in categories.indices {
            categories[index].isSelected = false
        }
    }
    
    private func saveRecipe() {
        if let recipe {
            recipe.title = recipeNameInput
            recipe.author = authorNameInput
            recipe.categories = categoriesInput
            recipe.hours = hoursInput
            recipe.minutes = minutesInput
            recipe.skillLevel = skillLevelInput.rawValue
            recipe.servingSize = servingSizeInput
            recipe.ingredients = ingredientsInput
            recipe.directions = directionsInput
            recipe.notes = notesInput
        } else {
            let newRecipe = Recipe(
                title: recipeNameInput,
                author: authorNameInput,
                date: dateInput,
                categories: [],
                hours: hoursInput,
                minutes: minutesInput,
                skillLevel: skillLevelInput,
                servingSize: servingSizeInput,
                ingredients: ingredientsInput,
                directions: directionsInput,
                notes: notesInput)
            modelContext.insert(newRecipe)
            newRecipe.categories = categoriesInput
        }
        dismiss()
    }
    
    
    //MARK: Constants
    
    private struct FormConstants {
        static let imageSize: CGFloat = 10
        static let fontSize: Font = .system(size: 18)
        static let buttonPadding: CGFloat = 10
        static let cornerRadius: CGFloat = 10
        static let verticalPickerPadding: CGFloat = 10
    }
}

struct FormSectionTextView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color(UIColor.darkGrey))
            .fontWeight(.bold)
    }
}

struct FormButtonView : View {
    
    let text: String
    let action: () -> Void
    let secondaryAction: (() -> Void)?
    let isAdding: Bool
    let cornerRadius: CGFloat
    
    var body: some View {
        Button(action: {
            action()
            if let secondaryAction {
                secondaryAction()
            }
        }) {
            HStack {
                Spacer()
                if isAdding {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 10 , height: 10)
                }
                Text(text)
                    .font(.system(size: 18))
                Spacer()
            }
            .padding(.vertical, 10)
        }
        .foregroundColor(Color(UIColor.white))
        .background(Color(UIColor.green))
        .cornerRadius(cornerRadius)
    }
}

struct TextInputView: View {
    @Binding var text: String
    
    let placeholder: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.grey))
                .cornerRadius(10)
            TextField(
                placeholder,
                text: $text,
                axis: .vertical
            )
            .padding(.horizontal, 15)
        }
        .frame(height: 50)
    }
}

struct MarkdownView: View {
    @Binding var text: String
    
    let sectionText: String
    let placeholderText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            FormSectionTextView(text: sectionText)
            
            ZStack(alignment: .leading) {
                TextEditor(text: $text)
                    .foregroundColor(Color(UIColor.darkGrey))
                    .padding(.horizontal, 12)
                    .padding(.top, 5)
                    .scrollContentBackground(.hidden)
                Text(text.isEmpty ? placeholderText : "")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 15)
                    .allowsHitTesting(false)
            }
            .background(Color(UIColor.grey))
            .frame(minHeight: 50, maxHeight: .infinity)
            .cornerRadius(10)
        }
    }
}

//colour, padding, frame, size, corner
