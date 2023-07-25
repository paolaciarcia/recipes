//
//  RecipeCell.swift
//  Recipes&Cooking
//
//  Created by Erick Borges on 04/02/21.
//

import UIKit

final class RecipeCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let portionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let time: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 2
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        selectionStyle = .none
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(image)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(portionsLabel)
        stackView.addArrangedSubview(time)
        addSubview(stackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            image.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            stackView.centerYAnchor.constraint(equalTo: image.centerYAnchor)
        ])
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        portionsLabel.text = nil
        time.text = nil
        image.image = nil
    }

    func prepareCell(recipe: RecipeModel) {
        titleLabel.text = recipe.dishName
        portionsLabel.text = "Porções: \(recipe.portions)"
        time.text =  "Tempo de Preparo: \(recipe.time)"

        if let recipeImage = recipe.dishImage {
            image.image = UIImage(data: recipeImage)
        } else {
            image.image = UIImage(named: "emptyState")
        }
    }
}
