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

    private let firstSectionView = InitialRecipeSectionView()

    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let ingridientsLabel = DescritionLabel("Ingredientes:")
    private let preparationMethodLabel = DescritionLabel("Modo de preparo:")
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
        button.layer.borderWidth = 2
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
        backgroundColor = .systemOrange
        firstSectionView.translatesAutoresizingMaskIntoConstraints = false
        ingridientsTextView.translatesAutoresizingMaskIntoConstraints = false
        ingridientsTextView.layer.cornerRadius = 8
        preparationMethodTextView.translatesAutoresizingMaskIntoConstraints = false
        preparationMethodTextView.layer.cornerRadius = 8
        setupViewHierarchy()
        setupConstraints()
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
            firstSectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
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
        print("continuar")
    }
}

//#Preview("FormView") {
//    let view = FormView()
//    return view
//}
