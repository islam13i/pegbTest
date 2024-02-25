//
//  NATextView.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

class NATextView: UITextView  {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure
extension NATextView {
    private func configure() {
        self.font = UIFont(name: Configure.Font.regular.rawValue, size: 14)
        textColor = Configure.Color.descriptionColor
        isScrollEnabled = true
        isEditable = false
        textContainer.lineFragmentPadding = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}
