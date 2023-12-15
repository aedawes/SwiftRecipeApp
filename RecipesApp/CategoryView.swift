//
//  CategoryView.swift
//  RecipesApp
//
//  Created by Emme Anais Dawes on 2023-12-04.
//

import SwiftUI
import SwiftData

//MARK: File Contents
//CatgoryView - View for the category modal

struct CategoryView: View {
    
    //MARK: Properties
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var categoryNameInput: String = ""
    
    @Binding var selectedCategoriesInput: Array<Category> //selected categories for this recipe
    
    let categories: Array<Category> //all categories
    
    
    //MARK: Main View
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        category.isSelected.toggle()
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(category.isSelected ? Color(UIColor.mediumGreen) : Color(UIColor.lightGreen))
                                .cornerRadius(CategoryConstants.cornerRadius)
                            HStack {
                                Text(category.name)
                                    .foregroundColor(Color(UIColor.darkGrey))
                                    .padding()
                                Spacer()
                                Button(action: {
                                    deleteCategory(category: category)
                                }) {
                                    Image(systemName: "trash.fill")
                                        .resizable()
                                        .foregroundColor(Color(UIColor.pink))
                                        .padding(.horizontal, 10)
                                        .frame(width: 20 , height: 20)
                                }
                            }
                        }
                    }
                }
                Spacer()
                HStack {
                    TextInputView(text: $categoryNameInput, placeholder: "Add a category")
                    
                    //Add a category button
                    Button(action: {
                        addCategory()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: CategoryConstants.imageRatio , height: CategoryConstants.imageRatio)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 27)
                    }
                    .foregroundColor(Color(UIColor.white))
                    .background(Color(UIColor.green))
                    .cornerRadius(CategoryConstants.cornerRadius)
                }
                
                //Save categories
                Button(action: {
                    saveCategoriesToRecipe()
                }) {
                    HStack {
                        Spacer()
                        Text("Save")
                            .font(.system(size: 18))
                            .padding()
                        Spacer()
                    }
                }
                .foregroundColor(Color(UIColor.white))
                .background(Color(UIColor.green))
                .cornerRadius(CategoryConstants.cornerRadius)
            }
            .padding()
        }
    }
    
    
    //MARK: Methods
    
    func addCategory() {
        let newCategory = Category(categoryName: categoryNameInput)
        modelContext.insert(newCategory)
        categoryNameInput = ""
    }
    
    func deleteCategory(category: Category) {
        guard let categoryIndex = categories.firstIndex(where: { $0.name == category.name }) else {
            return
        }
        
        modelContext.delete(categories[categoryIndex])
    }
    
    func saveCategoriesToRecipe() {
        selectedCategoriesInput = categories.filter( { $0.isSelected } )
        dismiss()
    }
    
    
    //MARK: Constants
    
    private struct CategoryConstants {
        static let cornerRadius: CGFloat = 10
        static let imageRatio: CGFloat = 10
    }
}
