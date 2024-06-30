//
//  RecipeDetailsViewController.swift
//  MealApp
//
//  Created by Naveen Reddy on 28/06/24.
//

import Foundation
import UIKit


// MARK: - Recipe Details View Controller

class RecipeDetailsViewController: UIViewController {
    var recipe: Recipe!
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 5
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let instructionsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: "IngredientCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(ingredientsTableView)
        setupUI()
        configure(with: recipe)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ingredientsTableView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 300)
    }
    
    
    // MARK: - Setup UI
    
    func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel, instructionsLabel, ingredientsLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with recipe: Recipe) {
        nameLabel.text = recipe.strMeal
        instructionsLabel.text = "Instructions:\n\(recipe.strInstructions)"
        ingredientsLabel.text = getIngredients(from: recipe)
        imageView.loadImage(from: recipe.strMealThumb)
    }
    
    func getIngredients(from recipe: Recipe) -> String {
        var ingredients = [String]()
        if let ingredientsArray = recipe.ingredients {
            for ingredient in ingredientsArray {
                ingredients.append(". \(ingredient.name) - \(ingredient.measurement)")
            }
        }
        return ingredients.joined(separator: "\n")
    }
}


// MARK: - Extensions

extension Recipe {
    func getProperty(_ propertyName: String) -> String? {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let propertyName = child.label, propertyName == propertyName {
                return child.value as? String
            }
        }
        return nil
    }
}

extension UIImageView {
    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url) {
                self.image = UIImage(data: data)
            }
        }
    }
}

