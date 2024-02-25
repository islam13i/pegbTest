//
//  NACellDescriptionLabel.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

class NADescriptionLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont(name: Configure.Font.regular.rawValue, size: fontSize)
        configure()
    }
}

//MARK: - Configure
extension NADescriptionLabel {
    private func configure() {
        textColor = Configure.Color.descriptionColor
        numberOfLines = 0
        minimumScaleFactor = 0.75
        translatesAutoresizingMaskIntoConstraints = false
    }
}
