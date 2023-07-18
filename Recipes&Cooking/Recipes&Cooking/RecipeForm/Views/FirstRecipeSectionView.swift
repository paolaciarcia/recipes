//
//  InitialRecipeSectionView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 22/06/23.
//

import UIKit

final class FirstRecipeSectionView: UIView {
    var didInsertDishName: ((_ text: String?) -> Void)?
    var didInsertPortions: ((_ quantity: String?) -> Void)?
    var didInsertDuration: ((_ time: String?) -> Void)?
    var hasDishTextFieldEnoughCharacters: ((Int) -> Void)?
    var hasPortionsTextFieldEnoughCharacters: ((Int) -> Void)?
    var hasTimeTextFieldEnoughCharacters: ((Int) -> Void)?

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

    private lazy var dishTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.addTarget(self, action: #selector(handleDishNameTextField), for: .editingChanged)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var portionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.addTarget(self, action: #selector(handlePortionsTextField), for: .editingChanged)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var cookingTimeTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.placeholder = "Ex: 60 min"
        textField.delegate = self
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
        bindLayoutEvents()
        setupViewHierarchy()
        setupConstraints()
    }

    private func bindLayoutEvents() {
        didInsertDishName?(dishTextField.text)
        didInsertPortions?(portionTextField.text)
        didInsertDuration?(cookingTimeTextField.text)
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

    @objc private func handleDishNameTextField() {
        guard let dishTextFieldCount = dishTextField.text?.count else { return }
        hasDishTextFieldEnoughCharacters?(dishTextFieldCount)
    }

    @objc private func handlePortionsTextField() {
        guard let portionsTextFieldCount = portionTextField.text?.count else { return }
        hasPortionsTextFieldEnoughCharacters?(portionsTextFieldCount)
    }

    @objc private func handleTimeTextField() {
        guard let timeTextFieldCount = cookingTimeTextField.text?.count else { return }
        hasTimeTextFieldEnoughCharacters?(timeTextFieldCount)
    }
}

extension FirstRecipeSectionView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        didInsertDishName?(dishTextField.text)
        didInsertPortions?(portionTextField.text)
        didInsertDuration?(cookingTimeTextField.text)

        textField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
