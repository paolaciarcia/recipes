//
//  DescritionLabel.swift
//  Recipes&Cooking
//
//  Created by Paola Golombieski Ciarcia on 22/06/23.
//

import Foundation
import UIKit

final class DescritionLabel: UILabel {
    init(_ text: String) {
        super.init(frame: .zero)
        self.text = text
        textColor = .white
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
