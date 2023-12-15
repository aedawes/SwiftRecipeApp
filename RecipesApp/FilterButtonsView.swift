//
//  FilterButtonsView.swift
//  RecipeApp
//
//  Created by Emme Anais Dawes on 2023-11-29.
//

import SwiftUI

//MARK: File Contents
//FilterButtonView - View for all three filter buttons
//FilterButton - View for a single button

struct FilterButtonsView: View {
    
    //MARK: Properties
    
    @Binding var searchText: String
    @Binding var selectedFilter: RecipeHomeView.Filter
    
    let geometryWidth: CGFloat
    
    
    //MARK: Main View
    
    var body: some View {
        HStack {
            filterButton(buttonText: RecipeHomeView.Filter.all.rawValue, geometryWidth: geometryWidth, isSelected: selectedFilter == RecipeHomeView.Filter.all)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.3)) {
                        selectedFilter = RecipeHomeView.Filter.all
                    }
                }
            Spacer()
            filterButton(buttonText: RecipeHomeView.Filter.categories.rawValue, geometryWidth: geometryWidth, isSelected: selectedFilter == RecipeHomeView.Filter.categories)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.3)) {
                        selectedFilter = RecipeHomeView.Filter.categories
                    }
                }
            Spacer()
            filterButton(buttonText: RecipeHomeView.Filter.favourites.rawValue, geometryWidth: geometryWidth, isSelected: selectedFilter == RecipeHomeView.Filter.favourites)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.3)) {
                        selectedFilter = RecipeHomeView.Filter.favourites
                    }
                }
        }
    }
}

struct filterButton: View {
    
    //MARK: Properties
    
    let buttonText: String
    let geometryWidth: CGFloat
    var isSelected: Bool
    
    
    //MARK: Main View
    
    var body: some View {
            Text(buttonText)
                .font(.system(size: FilterConstants.buttonFontSize))
                .fontWeight(.bold)
                .padding(.vertical, FilterConstants.buttonVerticalPadding)
                .frame(width: buttonWidth(geometryWidth: geometryWidth))
                .foregroundColor(Color(isSelected ? .white : UIColor.darkGrey))
                .background(Color(isSelected ? UIColor.green : UIColor.grey))
                .cornerRadius(FilterConstants.cornerRadius)
    }
    
    
    //MARK: Methods
    
    private func buttonWidth(geometryWidth: CGFloat) -> CGFloat {
        geometryWidth * 0.3
    }
    
    private struct FilterConstants {
        static let buttonFontSize: CGFloat = 15
        static let buttonVerticalPadding: CGFloat = 20
        static let cornerRadius: CGFloat = 8
    }
}

