//
//  ViewController.swift
//  MealApp
//
//  Created by Naveen Reddy on 28/06/24.
//

import UIKit

// MARK: - View Controllers

class RecipeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let recipeService = RecipeAPI()
    var recipes: [Recipe] = []
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchDesserts()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style:.plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchDesserts() {
        recipeService.fetchDesserts { [weak self] recipes in
            DispatchQueue.main.async {
                self?.recipes = recipes
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        let myRecipe = RecipeSummary(name: recipe.strMeal ?? "Unknown meal",
                                description: recipe.strInstructions ?? "Unknown instructions",
                                image: UIImage(systemName: "fork.knife") as UIImage? ?? UIImage())
        cell.configure(with: myRecipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipes[indexPath.row]
        let recipeDetailsViewController = RecipeDetailsViewController()
        recipeDetailsViewController.recipe = selectedRecipe
        navigationController?.pushViewController(recipeDetailsViewController, animated: true)
    }
}




// MARK: - Recipe Cell

class RecipeCell: UITableViewCell {
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let recipeImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup UI
    
    func setupUI() {
        nameLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.font = .systemFont(ofSize: 15)
        recipeImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(recipeImageView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            recipeImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with recipe: RecipeSummary) {
        nameLabel.text = recipe.name
        descriptionLabel.text = recipe.description
        recipeImageView.image = recipe.image
    }
}
