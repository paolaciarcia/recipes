//
//  RecipeDetailView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 29/06/23.
//

import UIKit

final class RecipeDetailView: UIView {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "defaultImage")
//        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 4
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.backgroundColor = .yellow
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Frango gratinado é muito gosto eu amo comer frango"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = UIColor.orange
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Preparo: 120 min"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let portionLabel: UILabel = {
        let label = UILabel()
        label.text = "Porções: 2"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ingridientsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredientes:"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ingridientsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Modo de preparo:"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let instructionsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(imageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(timeDescriptionLabel)
        mainStackView.addArrangedSubview(portionLabel)
        mainStackView.addArrangedSubview(ingridientsTitleLabel)
        mainStackView.addArrangedSubview(ingridientsDescriptionLabel)
        mainStackView.addArrangedSubview(instructionsTitleLabel)
        mainStackView.addArrangedSubview(instructionsDescriptionLabel)

        addSubview(mainStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
//            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
}

#Preview("RecipeDetailView") {
    let view = RecipeDetailView()
    return view
}

