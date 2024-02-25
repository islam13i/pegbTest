//
//  NAAvatarImageView.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

class NAAvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure
extension NAAvatarImageView {
    private func configure() {
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
