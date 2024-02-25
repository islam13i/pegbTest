//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit
import SnapKit

class FavoritesVC: UIViewController {

    private lazy var tableViewFavorites = UITableView()
    private lazy var emptyListLabel = NATitleLabel(font: UIFont.systemFont(ofSize: 24, weight: .bold), color: .black)

    var viewModel = FavoritesTableViewModel()
    private lazy var logoButton: UIBarButtonItem = {
        
        let button = UIBarButtonItem()
        return button
    }()
    
    private lazy var logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: Configure.IconImage.logout), style: .plain, target: self, action: #selector(logoutButtonTapped))
        //        button.image = UIImage(named: Configure.IconImage.logout)
        button.tintColor = .black
        return button
    }()
}

//MARK: - Lifecycle
extension FavoritesVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewFavorites.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoritedNewsItem()
        reloadTableView()
    }
}

//MARK: - SetUpUI
extension FavoritesVC {
    func setUpUI() {
        self.view.backgroundColor = Configure.Color.viewBackground
        configureNavigationBarTitle()
        configureTableView()
        configureEmptyListLabel()
    }

}

//MARK: - Configure
extension FavoritesVC {
    private func configureNavigationBarTitle() {
        
        self.tabBarController?.navigationItem.hidesBackButton = true
        let attributes = [NSAttributedString.Key.foregroundColor: Configure.Color.cellTitleColor, NSAttributedString.Key.font : UIFont(name: Configure.Font.medium.rawValue, size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        if let lastCharacter = UserDefaults.standard.string(forKey: "logedUsername")?.suffix(1).first {
            let logo = UIButton()
            logo.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            logo.layer.borderWidth = 2
            logo.layer.cornerRadius = 17
            logo.clipsToBounds = true
            let lastCharacterAsString = String(lastCharacter)
            logo.setTitle(lastCharacterAsString, for: .normal)
            logo.setTitleColor(.black, for: .normal)
            logoButton.customView = logo
            navigationItem.leftBarButtonItem = logoButton
            print("Last character: \(lastCharacterAsString)")
        } else {
            print("The string is empty.")
        }
        
        navigationItem.rightBarButtonItem = logoutButton
    }

    private func configureTableView() {
        self.view.addSubview(tableViewFavorites)
        tableViewFavorites.translatesAutoresizingMaskIntoConstraints = false
        tableViewFavorites.backgroundColor = Configure.Color.clearColor
        tableViewFavorites.dataSource = self
        tableViewFavorites.delegate = self
        tableViewFavorites.separatorStyle = .none
        tableViewFavorites.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
    }

    private func configureEmptyListLabel() {
        emptyListLabel.backgroundColor = Configure.Color.clearColor
        emptyListLabel.textAlignment = .center
        emptyListLabel.adjustsFontForContentSizeCategory = true
        emptyListLabel.text = NSLocalizedString("Your favorite news list is empty!", comment: "")
        self.view.addSubview(emptyListLabel)
        emptyListLabel.snp.makeConstraints { (make) in
        make.edges.equalToSuperview()
        }
    }
    
    @objc func logoutButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: TableView Delegate & DataSource
extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    private func reloadTableView() {
        self.showLoadingView()
        if viewModel.favoritedNews.count == 0 {
            tableViewFavorites.alpha = 0
            emptyListLabel.alpha = 1
        } else {
            tableViewFavorites.alpha = 1
            emptyListLabel.alpha = 0
        }
        tableViewFavorites.reloadData()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(5), execute: { [weak self] in
            self!.dismissLoadingView()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritedNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        let cellItem = viewModel.favoritedNews[indexPath.row]
        let url = URL(string: cellItem.newsImage ?? "")
        cell.setCell(title: cellItem.newsTitle ?? "", author: cellItem.newsAuthor ?? "", date: cellItem.newsPublishDate ?? "", isFavorite: true)
        cell.newsImage.kf.setImage(with: url, placeholder: UIImage(named: Configure.IconImage.placeholder))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsDetailVC = NewsDetailVC()
        let favoriteNewsArray = viewModel.favoritedNews[indexPath.row]
        let favoriteNews = Articles(source: Source(id: "", name: ""),
                            author: favoriteNewsArray.newsAuthor,
                            title: favoriteNewsArray.newsTitle,
                            description: favoriteNewsArray.newsDescription,
                            urlLink: favoriteNewsArray.newsUrlLink,
                            image: viewModel.favoritedNews[indexPath.row].newsImage,
                            publishDate: favoriteNewsArray.newsPublishDate,
                            content: favoriteNewsArray.newsContent)
        newsDetailVC.viewModel.news = favoriteNews
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: NSLocalizedString("Delete", comment: "")) { [weak self] (action, view, completionHandler) in
            guard let self = self else{
            completionHandler(false)
            return
            }
        self.handleDelete(indexPath: indexPath)
        completionHandler(true)
        }
        delete.backgroundColor = Configure.Color.redColor
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }

    private func handleDelete(indexPath: IndexPath) {
        Alerts.showAlertDelete(controller: self, NSLocalizedString("Are you sure you want to delete this news from favorite list?", comment: "")) { [self] in
            self.viewModel.deleteFavoriteNewsItem(item: self.viewModel.favoritedNews[indexPath.row])
            viewModel.getFavoritedNewsItem()
            tableViewFavorites.deleteRows(at: [indexPath], with: .fade)
            reloadTableView()
        }
    }
}
