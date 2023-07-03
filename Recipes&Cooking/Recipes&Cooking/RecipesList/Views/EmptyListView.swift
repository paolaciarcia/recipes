//
//  EmptyListView.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 09/06/23.
//

import UIKit

final class EmptyListView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label .text = "Ainda não foi adicionado nenhuma receita a lista. Vá em '+' para criar a primeira"
        label.textColor = .orange
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
//        bindLayoutEvents()
        backgroundColor = .white
        setupViewHierarchy()
        setupConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(messageLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

//#Preview("EmptyListView") {
//    let view = EmptyListView()
//    return view
//}
