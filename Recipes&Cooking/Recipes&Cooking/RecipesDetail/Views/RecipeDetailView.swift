//
//  RecipeDetailView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 29/06/23.
//

import UIKit

final class RecipeDetailView: UIView {
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = UIColor.orange
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let portionLabel: UILabel = {
        let label = UILabel()
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
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.black
        label.numberOfLines = 0
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
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.black
        label.numberOfLines = 0
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
        addSubview(scrollView)

        scrollView.addSubview(imageView)
        scrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(timeDescriptionLabel)
        mainStackView.addArrangedSubview(portionLabel)
        mainStackView.addArrangedSubview(ingridientsTitleLabel)
        mainStackView.addArrangedSubview(ingridientsDescriptionLabel)
        mainStackView.addArrangedSubview(instructionsTitleLabel)
        mainStackView.addArrangedSubview(instructionsDescriptionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),

            mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }

    func show(viewModel: Recipe) {
        guard let time = viewModel.timePrepare,
              let portions = viewModel.portions else { return }

        titleLabel.text = viewModel.name
        setAttributedText(with: "Preparo: \(time)",
                          range: time,
                          label: timeDescriptionLabel)

        setAttributedText(with: "Porções: \(portions)",
                          range: portions,
                          label: portionLabel)
        ingridientsDescriptionLabel.text = viewModel.ingredients
        instructionsDescriptionLabel.text = viewModel.instructions

        if let convertedImage = viewModel.image {
            imageView.image = UIImage(data: convertedImage)
        } else {
            imageView.image = UIImage(named: "emptyState")
        }
    }

    private func setAttributedText(with string: String,
                                   range: String,
                                   label: UILabel) {
        let attributedString = NSMutableAttributedString(string: string)
        let range = (string as NSString).range(of: range)
        attributedString.addAttribute(.font,
                                      value: UIFont.preferredFont(forTextStyle: .body),
                                      range: range)
        label.attributedText = attributedString
    }
}
