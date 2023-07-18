//
//  FormView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 22/06/23.
//

import UIKit

final class FormView: UIView {
    var didInsertDishName: ((_ text: String?) -> Void)?
    var didInsertPortions: ((_ quantity: String?) -> Void)?
    var didInsertDuration: ((_ time: String?) -> Void)?
    var didInsertIngridients: ((String) -> Void)?
    var didInsertIInstructions: ((String) -> Void)?
    var didTouchAddImage: (() -> Void)?
    var didTouchContinueButton: (() -> Void)?
    var hasDishTextFieldEnoughCharacters: ((Int) -> Void)?
    var hasPortionsTextFieldEnoughCharacters: ((Int) -> Void)?
    var hasTimeTextFieldEnoughCharacters: ((Int) -> Void)?
    var textViewIngridientsCount: ((Int) -> Void)?
    var textViewInstructionsCount: ((Int) -> Void)?

    private let firstSectionView = FirstRecipeSectionView()
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let spacingView = UIView()

    private let ingridientsLabel = DescritionLabel("Ingredientes:")
    private let preparationMethodLabel = DescritionLabel("Modo de preparo:")
    private lazy var ingridientsTextView = UITextView()
    private lazy var preparationMethodTextView = UITextView()

    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar imagem", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addImageHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("SALVAR", for: .normal)
//        button.isEnabled = false
//        button.setTitleColor(.systemGray, for: .normal)
//        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(saveRecipe), for: .touchUpInside)
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
        backgroundColor = .systemOrange
        firstSectionView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        setupTextView()
        bindLayoutEvents()
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupTextView() {
        ingridientsTextView.translatesAutoresizingMaskIntoConstraints = false
        ingridientsTextView.layer.cornerRadius = 8
        preparationMethodTextView.translatesAutoresizingMaskIntoConstraints = false
        preparationMethodTextView.layer.cornerRadius = 8

        ingridientsTextView.delegate = self
        preparationMethodTextView.delegate = self
    }

    private func bindLayoutEvents() {
        firstSectionView.didInsertDishName = { [weak self] name in
            self?.didInsertDishName?(name)
        }
        firstSectionView.didInsertPortions = { [weak self] quantity in
            self?.didInsertPortions?(quantity)
        }
        firstSectionView.didInsertDuration = { [weak self] time in
            self?.didInsertDuration?(time)
        }

        firstSectionView.hasDishTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.hasDishTextFieldEnoughCharacters?(characterCount)
        }

        firstSectionView.hasPortionsTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.hasPortionsTextFieldEnoughCharacters?(characterCount)
        }

        firstSectionView.hasTimeTextFieldEnoughCharacters = { [weak self] characterCount in
            self?.hasTimeTextFieldEnoughCharacters?(characterCount)
        }

        didInsertIngridients?(ingridientsTextView.text)
        didInsertIInstructions?(preparationMethodTextView.text)
    }

    private func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(firstSectionView)
        scrollView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(ingridientsLabel)
        verticalStackView.addArrangedSubview(ingridientsTextView)
        verticalStackView.addArrangedSubview(preparationMethodLabel)
        verticalStackView.addArrangedSubview(preparationMethodTextView)
        verticalStackView.addArrangedSubview(addImageButton)
        verticalStackView.addArrangedSubview(spacingView)
        verticalStackView.addArrangedSubview(continueButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            firstSectionView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            firstSectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            firstSectionView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: firstSectionView.bottomAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 12),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -12),

            spacingView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            ingridientsTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            preparationMethodTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc
    private func addImageHandler() {
        didTouchAddImage?()
    }

    @objc
    private func saveRecipe() {
        didTouchContinueButton?()
    }
}

extension FormView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        didInsertIngridients?(ingridientsTextView.text)
        didInsertIInstructions?(preparationMethodTextView.text)
        textView.resignFirstResponder()
    }

    func textViewDidChange(_ textView: UITextView) {
        let ingredientsCount = ingridientsTextView.text.count
        let instructionsCount = preparationMethodTextView.text.count
        textViewIngridientsCount?(ingredientsCount)
        textViewInstructionsCount?(instructionsCount)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
