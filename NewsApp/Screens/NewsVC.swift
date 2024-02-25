//
//  NewsVC.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit
import Kingfisher

class NewsVC: UIViewController {
    
    private lazy var tableViewNews = UITableView()
    
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
    var viewModel = NewsViewModel()
    var page: Int = 1
    private lazy var searchVC = UISearchController(searchResultsController: nil)
}

//MARK: - Lifecycle
extension NewsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.delegate = self
        viewModel.topNewsFetched(page: 1)
    }
}

//MARK: - SetUpUI
extension NewsVC {
    private func setUpUI() {
        self.view.backgroundColor = Configure.Color.viewBackground
        configureNavigationBarTitle()
        configureSearchBar()
        configureTableView()
    }
}

//MARK: - Configure
extension NewsVC {
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
    
    private func configureSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = NSLocalizedString("Search News", comment: "")
    }
    
    private func configureTableView() {
        self.view.addSubview(tableViewNews)
        tableViewNews.translatesAutoresizingMaskIntoConstraints = false
        tableViewNews.separatorStyle = .none
        tableViewNews.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableViewNews.backgroundColor = Configure.Color.clearColor
        tableViewNews.dataSource = self
        tableViewNews.delegate = self
        tableViewNews.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
    }
    
    @objc func logoutButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: - Pagination
extension NewsVC {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            self.viewModel.topNewsFetched(page: self.page)
        }
    }
}
//MARK: - NewsViewModel Delegate
extension NewsVC: NewsViewModelDelegate {
    func loadIndicatorForApiRequestCompleted() {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
    }
    
    func dissmissIndicatorForApiRequestCompleted() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(30), execute: { [weak self] in
            self!.dismissLoadingView()
        })
    }
    
    func reloadTableViewAfterIndicator() {
        DispatchQueue.main.async {
            self.tableViewNews.reloadData()
        }
    }
}


//MARK: - SearchBar Delegate
extension NewsVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        self.searchVC.dismiss(animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.topNewsFetched(page: 1)
        self.searchVC.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - TableView Delegate & Datasource
extension NewsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInNewsList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        let news = viewModel.news[indexPath.row]
        var favorite = false
        viewModel.checkIsNewsFavorite(title: news.title ?? "", completion: {[weak self] (isFavorite) in
            favorite = isFavorite
        })
        cell.setCell(title: news.title ?? "", author: news.author ?? "", date: news.publishDate ?? "", isFavorite: favorite)
        let url = URL(string: viewModel.news[indexPath.row].image ?? "")
        cell.newsImage.kf.setImage(with: url, placeholder: UIImage(named: Configure.IconImage.placeholder))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsDetailVC = NewsDetailVC()
        newsDetailVC.viewModel.news = viewModel.news[indexPath.row]
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
}
