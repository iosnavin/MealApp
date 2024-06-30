//
//  RecipeAPI.swift
//  MealApp
//
//  Created by Naveen Reddy on 29/06/24.
//

import Foundation
import UIKit


// MARK: - API

class RecipeAPI {
    let apiKey = "1"
    let baseURL = "https://www.themealdb.com/api/json/v1/"
    
    func fetchDesserts(completion: @escaping ([Recipe]) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching desserts: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let recipes = try JSONDecoder().decode(MealResponse.self, from: data).meals
                DispatchQueue.main.async {
                    completion(recipes)
                }
            } catch {
                print("Error decoding recipes: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchMealDetails(mealId: String, completion: @escaping ([Recipe]) -> Void) {
        guard let url = URL(string: "\(baseURL)1/lookup.php?i=\(mealId)") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching meal details: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let recipes = try JSONDecoder().decode(MealResponse.self, from: data).meals
                DispatchQueue.main.async {
                    completion(recipes)
                }
            } catch {
                print("Error decoding recipes: \(error.localizedDescription)")
            }
        }.resume()
    }
}
