//
//  NAView.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit


class NAView: UIView {
    
    lazy var textLabel = NATitleLabel(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: .white)
    private lazy var iconImage = NAAvatarImageView(frame: .zero)
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
}

//MARK: - Configure
extension NAView {
    private func configure() {
        self.addSubview(textLabel)
        self.addSubview(iconImage)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        textLabel.textColor = .white
        textLabel.sizeToFit()
        textLabel.textAlignment = .center
        iconImage.tintColor = .white
        
        iconImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(padding)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImage.snp.right)
            make.right.equalToSuperview().offset(-padding)
            make.height.equalToSuperview()
        }
    }
    
    func setText(text: String) {
        iconImage.image = UIImage(named: Configure.IconImage.calendarIcon)
        textLabel.text = text.convertToDisplayFormat()
    }
}

