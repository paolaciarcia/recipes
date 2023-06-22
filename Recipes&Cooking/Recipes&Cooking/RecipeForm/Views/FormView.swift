//
//  FormView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 22/06/23.
//

import Foundation
import UIKit

final class FormView: UIView {
    var isContinueButtonEnabled: Bool = false

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
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let dishNameLabel = DescritionLabel("Nome do prato:")
    private let portionAmountLabel = DescritionLabel("Porções:")
    private let cookingTimeLabel = DescritionLabel("Tempo de preparo:")
    private let ingridientsLabel = DescritionLabel("Ingredientes:")
    private let preparationMethodLabel = DescritionLabel("Modo de preparo:")

    private let dishTextField = UITextField()
    private let portionTextField = UITextField()
    private let cookingTimeField = UITextField()

    private let ingridientsTextView = UITextView()
    private let preparationMethodTextView = UITextView()

    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar imagem(opcional)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = isContinueButtonEnabled
        button.addTarget(self, action: #selector(addImageHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("CONTINUAR", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 24
        button.isEnabled = isContinueButtonEnabled
        button.addTarget(self, action: #selector(continueButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        dishTextField.translatesAutoresizingMaskIntoConstraints = false
        portionTextField.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeField.translatesAutoresizingMaskIntoConstraints = false
        ingridientsTextView.translatesAutoresizingMaskIntoConstraints = false
        preparationMethodTextView.translatesAutoresizingMaskIntoConstraints = false
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(firstHorizontalStackView)
        firstHorizontalStackView.addArrangedSubview(dishNameLabel)
        firstHorizontalStackView.addArrangedSubview(dishTextField)
        addSubview(secondHorizontalStackView)
        secondHorizontalStackView.addArrangedSubview(portionAmountLabel)
        secondHorizontalStackView.addArrangedSubview(portionTextField)
        addSubview(thirdHorizontalStackView)
        thirdHorizontalStackView.addArrangedSubview(cookingTimeLabel)
        thirdHorizontalStackView.addArrangedSubview(cookingTimeField)

        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(firstHorizontalStackView)
        verticalStackView.addArrangedSubview(secondHorizontalStackView)
        verticalStackView.addArrangedSubview(thirdHorizontalStackView)
        verticalStackView.addArrangedSubview(ingridientsLabel)
        verticalStackView.addArrangedSubview(ingridientsTextView)
        verticalStackView.addArrangedSubview(preparationMethodLabel)
        verticalStackView.addArrangedSubview(preparationMethodTextView)
        verticalStackView.addArrangedSubview(addImageButton)
        verticalStackView.addArrangedSubview(continueButton)

    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])

    }

    @objc private func addImageHandler() {
        print("buscar imagem")
    }

    @objc private func continueButtonHandler() {
        print("continuar")
    }
}
