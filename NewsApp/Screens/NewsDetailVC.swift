//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit
import SafariServices

class NewsDetailVC: UIViewController {
    private lazy var newsTitle = NATitleLabel(font: UIFont.systemFont(ofSize: 24, weight: .bold), color: .white)
    private lazy var newsDescription = NATextView()
    private lazy var newsImage = NAAvatarImageView(frame: .zero)
    private lazy var padding: CGFloat = 12

    let viewModel = NewsDetailViewModel()
    
    private var backButton = UIBarButtonItem()
    private lazy var favoriteButton = UIBarButtonItem()
    private lazy var newsIcon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .black
        icon.contentMode = .scaleAspectFill
        return icon
    }()

    private lazy var authorNameView = NATitleLabel(font: UIFont.systemFont(ofSize: 14, weight: .bold), color: .black)
    private lazy var sourceView = NATitleLabel(font: UIFont.systemFont(ofSize: 12, weight: .medium), color: .white)
    private lazy var dateView = NAView()
}

//MARK: - Lifecycle
extension NewsDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkIsNewsFavorite() { [weak self] (isFavorite) in
            guard let self = self else { return }
            if isFavorite {
                self.favoriteButton.image = UIImage(named: Configure.IconImage.favoritesFillIcon)
            } else {
                self.favoriteButton.image = UIImage(named: Configure.IconImage.favoritesIcon)
            }
        }
    }
}

//MARK: - SetUpUI
extension NewsDetailVC {
    private func setUpUI() {
        self.view.backgroundColor = .white
        configureNavigationBar()
        self.view.addSubview(newsImage)
        self.view.addSubview(newsTitle)
        self.view.addSubview(newsDescription)
        self.view.addSubview(dateView)
        self.view.addSubview(sourceView)
        self.view.addSubview(authorNameView)
        self.view.addSubview(newsIcon)
    

        newsImage.backgroundColor = Configure.Color.clearColor
        newsTitle.backgroundColor = Configure.Color.clearColor
        newsDescription.backgroundColor = Configure.Color.clearColor
        newsIcon.image = UIImage(named: Configure.IconImage.authorIcon)

        newsImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        dateView.snp.makeConstraints { (make) in
            make.right.equalTo(newsImage.snp.right).offset(-padding)
            make.bottom.equalTo(newsImage.snp.bottom).offset(-padding)
            make.height.equalTo(17)
        }
        
        sourceView.snp.makeConstraints { (make) in
            make.left.equalTo(newsImage.snp.left).offset(padding)
            make.bottom.equalTo(newsImage.snp.bottom).offset(-padding)
            make.height.equalTo(17)
        }

        newsTitle.snp.makeConstraints { (make) in
            make.left.equalTo(newsImage.snp.left).offset(padding)
            make.right.equalTo(newsImage.snp.right).offset(-40)
            make.top.equalTo(newsImage.snp.centerY).offset(padding)
            make.bottom.equalTo(sourceView.snp.top).offset(-padding)
        }

        authorNameView.snp.makeConstraints { (make) in
            make.top.equalTo(newsImage.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(padding)
        }
        
        newsIcon.snp.makeConstraints { (make) in
            make.size.equalTo(15)
            make.centerY.equalTo(authorNameView.snp.centerY)
            make.right.equalTo(view.snp.right).offset(-padding)
        }

        newsDescription.snp.makeConstraints { (make) in
            make.top.equalTo(authorNameView.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left).offset(padding)
            make.right.equalTo(view.snp.right).offset(-padding)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-padding)
        }
    }
}

//MARK: - Configure NavigattionBar
extension NewsDetailVC {
    private func configureNavigationBar() {
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController!.navigationBar.tintColor = Configure.Color.titleColor
        favoriteButton = UIBarButtonItem(image: UIImage(named: Configure.IconImage.favoritesIcon), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        backButton = UIBarButtonItem(image: UIImage(named: Configure.IconImage.back), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = favoriteButton
        navigationItem.rightBarButtonItem = backButton
    }
}

//MARK: - Set Data
extension NewsDetailVC {
    private func setData() {
        let url = URL(string: viewModel.news?.image ?? "")
        newsImage.kf.setImage(with: url, placeholder: UIImage(named: Configure.IconImage.placeholder))
        let attributedString = NSMutableAttributedString(string: viewModel.news?.title ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        newsTitle.attributedText = attributedString
        authorNameView.text = viewModel.news?.author  ?? NSLocalizedString("Unknown Author", comment: "")
        dateView.setText(text: viewModel.news?.publishDate ?? NSLocalizedString("Unknown Date", comment: ""))
        sourceView.text = viewModel.news?.source.name  ?? NSLocalizedString("Unknown Source", comment: "")
        newsDescription.text = viewModel.news?.description ?? NSLocalizedString("Unknown Description", comment: "")
    }
}

//MARK: - Actions
extension NewsDetailVC {

    @objc func favoriteButtonTapped() {
        viewModel.checkIsNewsFavorite() { [weak self] (isFavorite) in
            guard let self = self else { return }
            if isFavorite {
                self.favoriteButton.image = UIImage(named: Configure.IconImage.favoritesIcon )
                self.viewModel.deleteFav(self.viewModel.news.title ?? "")
                return
            } else {
                self.favoriteButton.image = UIImage(named: Configure.IconImage.favoritesFillIcon )
                self.showToast(title: NSLocalizedString("Favorite news", comment: ""), text: NSLocalizedString("This news has been added to your favorite list.", comment: ""), delay: 1)
                self.viewModel.makeFavoriteNews()
            }
        }
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - SafariViewController Delegate
extension NewsDetailVC: SFSafariViewControllerDelegate {
    @objc func newsSourceTapped() {
        guard let url = URL(string: (viewModel.news?.urlLink)!) else {
            print(NAError.invalidURLLink)
            return
        }
        let websiteVC = SFSafariViewController(url: url)
        websiteVC.delegate = self
        present(websiteVC, animated: true)
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
