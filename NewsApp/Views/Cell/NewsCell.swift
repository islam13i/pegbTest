//
//  NewsCell.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit
import SnapKit

class NewsCell: UITableViewCell {
    static let reuseID = "NewsCell"
    lazy var newsTitle = NATitleLabel(font: UIFont.systemFont(ofSize: 15, weight: .medium), color: .black)
    lazy var newsAuthor = NADescriptionLabel(fontSize: 12)
    lazy var newsDate = NADescriptionLabel(fontSize: 12)
    lazy var newsImage = NAAvatarImageView(frame: .zero)
    lazy var newsIconFavorite: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: Configure.IconImage.favoritesIcon)
        icon.tintColor = .black
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    private lazy var padding: CGFloat = 14
    private lazy var cornerRadius: CGFloat = 16

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Configure.Color.viewBackground
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Configure.Color.viewBackground
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitle.text = nil
        newsAuthor.text = nil
        newsDate.text = nil
        newsImage.image = nil
    }
}

//MARK: - Configure
extension NewsCell {
    private func configureCell() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(newsTitle)
        self.containerView.addSubview(newsAuthor)
        self.containerView.addSubview(newsImage)
        self.containerView.addSubview(newsDate)
        self.containerView.addSubview(newsIconFavorite)

        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(padding/1.5)
            make.bottom.equalToSuperview().offset(-padding/1.5)
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
        }

        newsAuthor.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.60)
        }
        
        newsTitle.snp.makeConstraints { (make) in
            make.top.equalTo(newsAuthor.snp.bottom).offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.width.equalToSuperview().multipliedBy(0.60)
        }
        
        newsIconFavorite.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitle.snp.bottom).offset(padding)
            make.bottom.equalToSuperview().offset(-padding)
            make.right.equalToSuperview().offset(-padding)
            make.size.equalTo(20)
        }
        
        newsDate.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitle.snp.bottom).offset(padding)
            make.bottom.equalToSuperview().offset(-padding)
            make.left.equalTo(newsTitle.snp.left)
            make.right.equalTo(newsIconFavorite.snp.left).offset(-padding)
        }

        newsImage.layer.cornerRadius = cornerRadius
        newsImage.clipsToBounds = true
        newsImage.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalTo(newsAuthor.snp.left).offset(-padding)
        }
    }
}

//MARK: - Set Cell
extension NewsCell {
    func setCell(title: String, author: String, date: String, isFavorite: Bool) {
        newsTitle.text = title
        newsAuthor.text = author
        newsDate.text = date.convertToDisplayCellFormat()
        if isFavorite {
            self.newsIconFavorite.image = UIImage(named: Configure.IconImage.favoritesFillIcon)
        } else {
            self.newsIconFavorite.image = UIImage(named: Configure.IconImage.favoritesIcon)
        }
    }
}
