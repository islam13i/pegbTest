//
//  NACellTitleLabel.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

class NATitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(font: UIFont, color: UIColor) {
        super.init(frame: .zero)
        self.font = font
        configure(color: color)
    }
}

//MARK: - Configure
extension NATitleLabel {
    private func configure(color: UIColor) {
        textColor = color
        adjustsFontSizeToFitWidth = true
        numberOfLines = 0
        
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
