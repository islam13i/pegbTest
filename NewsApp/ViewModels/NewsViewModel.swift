//
//  NewsListModel.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func loadIndicatorForApiRequestCompleted()
    func dissmissIndicatorForApiRequestCompleted()
    func reloadTableViewAfterIndicator()
}

class NewsViewModel {
    private var persistanceManager = FavoritesTableViewModel()
    weak var delegate: NewsViewModelDelegate?
    private var service = NetworkManager.shared
    
    var news: [Articles] = []

    func getNumberOfRowsInNewsList() -> Int {
        return news.count
    }
}

//MARK: - NetworkManagerDelegate
extension NewsViewModel: NetworkManagerDelegate {
    func topNewsFetched(page: Int) {
        self.delegate?.loadIndicatorForApiRequestCompleted()
        service.makeRequest(endpoint: .topNews(page: page), type: NewsModel.self) { result in
            self.delegate?.dissmissIndicatorForApiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self.news = news.articles : self.news.append(contentsOf: news.articles)
                self.delegate?.reloadTableViewAfterIndicator()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkIsNewsFavorite(title: String, completion: @escaping((Bool) -> Void)) {
        persistanceManager.checkNewsItemData(with: title) { (response) in
            switch response {
            case .success(let isFavorite):
                completion(isFavorite)
            case .failure(let error):
                print(error)
            }
        }
    }
}
