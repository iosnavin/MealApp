//
//  IngredientTableViewCell.swift
//  MealApp
//
//  Created by Naveen Reddy on 29/06/24.
//

import Foundation
import UIKit

class IngredientTableViewCell: UITableViewCell {
    // MARK: - Properties

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()

    let measurementLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(measurementLabel)
        setupConstraints()
    }

    // MARK: - Setup Constraints

    func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: measurementLabel.leadingAnchor, constant: -8),

            measurementLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            measurementLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }

    // MARK: - Configuration

    func configure(with ingredient: Ingredient) {
        nameLabel.text = ingredient.name
        measurementLabel.text = ingredient.measurement
    }
}
