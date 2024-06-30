//
//  RecipeService.swift
//  MealApp
//
//  Created by Naveen Reddy on 28/06/24.
//

import Foundation
import UIKit

// MARK: - Models

struct MealResponse: Decodable {
    let meals: [Recipe]
}

struct Ingredient: Decodable {
    let name: String
    let measurement: String
}

struct Recipe: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String?
    let ingredients: [Ingredient]?
}

struct RecipeSummary {
    let name: String
    let description: String
    let image: UIImage
}
