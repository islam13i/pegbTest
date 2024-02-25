//
//  NAButton.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

class NAButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String, textColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        configure()
    }
}

//MARK: - Configure
extension NAButton {
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: Configure.Font.medium.rawValue, size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
