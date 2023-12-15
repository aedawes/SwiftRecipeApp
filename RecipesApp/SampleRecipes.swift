//
//  SampleRecipes.swift
//  RecipesApp
//
//  Created by Emme Anais Dawes on 2023-12-14.
//

import Foundation

let sampleLebkuchengewürzCategories = [
    Category(categoryName: "Condiment"),
    Category(categoryName: "German"),
]

let samplePfeffernüsseCategories = [
    Category(categoryName: "Spicy"),
    Category(categoryName: "German"),
]

let sampleRecipes = [
    Recipe(
        title: "Lebkuchengewürz",
        author: "Kimberly Killebrew",
        isFavourite: false,
        date: Date(),
        categories: [],
        hours: 0,
        minutes: 5,
        skillLevel: Recipe.SkillLevel.Beginner,
        servingSize: 4,
        ingredients:
            """
                - 2 1/2 Tbsp ground cinnamon
                - 2 tsp ground cloves
                - 1/2 tsp ground allspice
                - 1/2 tsp ground coriander
                - 1/2 tsp ground green cardamom
                - 1/2 tsp ground ginger
                - 1/2 tsp ground star anise
                - 1/4 tsp ground mace
                - 1/4 tsp ground nutmeg
            """,
        directions:
            """
                1. Combine the spices together and store in an airtight jar in a cool, dark place for up to one year
                2. For superior flavor results, grind these spices from toasted and freshly ground whole spices. Simply heat a dry skillet over medium heat and toast the spices in it until very fragrant. Be careful not to scorch the spices or they will become bitter. Using the freshly ground blend within a few days is optimal.
            """,
        notes:
            """
                - Some spices, like ginger and mace, will not be readily available in whole form. You can buy ground ginger and ground mace instead
            """
    ),
    Recipe(
        title: "Pfeffernüsse",
        author: "Steve Liddle",
        isFavourite: true,
        date: Date(),
        categories: [],
        hours: 50,
        minutes: 0,
        skillLevel: Recipe.SkillLevel.Advanced,
        servingSize: 48,
        ingredients:
            """
                - 320g Bread flour
                - scant 1/2 tsp. Baking soda
                - 1/4 tsp. Salt
                - 4 tsp. Lebkuchengewürz
                - 1 tsp. Ground ginger*
                - 1/4 tsp. White pepper
                - 1/4 tsp. Black pepper*
                - 30g Almond meal
                - 100g Brown sugar
                - 113g Honey
                - 71g (5 Tbsp.) Unsalted butter
                - 50g (3 Tbsp.) Heavy cream
                - 25g (1+ Tbsp.) Molasses
                - 2 large Eggs
                - 300g Powdered sugar
                - 4 Tbsp. Hot water
            """,
        directions:
            """
                1. Mix the dry team in a small bowl.
                2. The wet team except egg goes in a saucepan.
                3. Heat, stirring frequently until melted and sugar dissolved.
                4. Let sit for 5 minutes.
                5. Mix in the dry team and then the egg.
                6.  Seal in cling wrap; refrigerate 24-48 hours. Time lets the dough blend and mature.
                7. Roll into two 3/4-inch snakes, cut into 3/4-inch slugs (~17g).
                8. Roll in balls and place on silicon or parchment lining. Chill for 20-30 minutes.
                9. Bake at 375 degrees for ~10 minutes
                10. Cool completely, dip in glaze.
                11. You can thin the glaze with hot water as desired.
            """,
        notes:
            """
                - Some spices, like ginger and mace, will not be readily available in whole form. You can buy ground ginger and ground mace instead
            """
    )]
