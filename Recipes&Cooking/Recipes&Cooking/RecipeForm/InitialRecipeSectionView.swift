//
//  InitialRecipeSectionView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 22/06/23.
//

import UIKit

final class InitialRecipeSectionView: UIView {
    
    private let firstHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let secondHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let thirdHorizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let dishNameLabel = DescritionLabel("Nome do prato:")
    private let portionAmountLabel = DescritionLabel("Porções:")
    private let cookingTimeLabel = DescritionLabel("Tempo de preparo:")

    private let dishTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let portionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let cookingTimeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        firstHorizontalStackView.addArrangedSubview(dishNameLabel)
        firstHorizontalStackView.addArrangedSubview(dishTextField)
        secondHorizontalStackView.addArrangedSubview(portionAmountLabel)
        secondHorizontalStackView.addArrangedSubview(portionTextField)
        thirdHorizontalStackView.addArrangedSubview(cookingTimeLabel)
        thirdHorizontalStackView.addArrangedSubview(cookingTimeTextField)
        
        verticalStackView.addArrangedSubview(firstHorizontalStackView)
        verticalStackView.addArrangedSubview(secondHorizontalStackView)
        verticalStackView.addArrangedSubview(thirdHorizontalStackView)
        addSubview(verticalStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            dishTextField.heightAnchor.constraint(equalToConstant: 30),
            portionTextField.heightAnchor.constraint(equalToConstant: 30),
            cookingTimeTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

#Preview("InitialRecipeSectionView") {
    let view = InitialRecipeSectionView()
    return view
}
