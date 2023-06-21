//
//  RecipeCell.swift
//  Recipes&Cooking
//
//  Created by Erick Borges on 04/02/21.
//

import UIKit

class RecipeCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 22,
                                            weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let portionsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13,
                                               weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let time: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 13,
                                       weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.tintColor = UIColor.secondarySystemFill
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 8
        image.layer.borderColor = CGColor(gray: 50, alpha: 1)
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
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),

            stackView.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        portionsLabel.text = nil
        time.text = nil
        image.image = nil
    }

    func prepareCell(recipe: Recipe) {
        titleLabel.text = recipe.name
        portionsLabel.text = "Porções: \(recipe.portions)"
        time.text =  "Tempo de Preparo: \(recipe.timePrepare)"

        image.image = recipe.image
    }
}

#Preview("RecipeCell") {
    let view = RecipeCell()
    view.prepareCell(recipe: Recipe(name: "Frango",
                                    timePrepare: 12,
                                    portions: 2,
                                    ingredients: "Frango, sal",
                                    instructions: "Modo de preparo",
                                    image: UIImage(systemName: "b.square.fill")))
    view.backgroundColor = .brown
    return view
}
