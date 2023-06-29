//
//  FormView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 22/06/23.
//

import Foundation
import UIKit

final class FormView: UIView {
    var didInsertDishName: ((_ text: String?) -> Void)?
    var didInsertPortions: ((_ quantity: String?) -> Void)?
    var didInsertDuration: ((_ time: String?) -> Void)?
    var didInsertIngridients: ((String) -> Void)?
    var didInsertIInstructions: ((String) -> Void)?
    var isButtonEnable: ((Bool) -> Void)?

    var didTouchContinueButton: (() -> Void)?

    private let firstSectionView = FirstRecipeSectionView()
    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let ingridientsLabel = DescritionLabel("Ingredientes:")
    private let preparationMethodLabel = DescritionLabel("Modo de preparo:")
    private lazy var ingridientsTextView = UITextView()
    private lazy var preparationMethodTextView = UITextView()

    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar imagem(opcional)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(addImageHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("CONTINUAR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 18
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
        backgroundColor = .systemOrange
        firstSectionView.translatesAutoresizingMaskIntoConstraints = false
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
        didInsertIngridients?(ingridientsTextView.text)
        didInsertIInstructions?(preparationMethodTextView.text)
    }

    private func setupViewHierarchy() {
        addSubview(firstSectionView)
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(ingridientsLabel)
        verticalStackView.addArrangedSubview(ingridientsTextView)
        verticalStackView.addArrangedSubview(preparationMethodLabel)
        verticalStackView.addArrangedSubview(preparationMethodTextView)
        verticalStackView.addArrangedSubview(addImageButton)
        verticalStackView.addArrangedSubview(continueButton)

    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstSectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            firstSectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstSectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.topAnchor.constraint(equalTo: firstSectionView.bottomAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            verticalStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            verticalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            ingridientsTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            preparationMethodTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func addImageHandler() {
        print("buscar imagem")
    }

    @objc private func continueButtonHandler() {
        didTouchContinueButton?()
        bindLayoutEvents()
    }

    func getRecipeInformations(from model: Recipe) {
        continueButton.isEnabled = model.isButtonEnable
    }
}

extension FormView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}
