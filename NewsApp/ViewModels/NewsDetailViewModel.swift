//
//  NewsDetailModel.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import UIKit

class NewsDetailViewModel {

    private var persistanceManager = FavoritesTableViewModel()
    let context = AppDelegate.content
    var news: Articles!

    func makeFavoriteNews() {
        let favoriteNews = FavoriteNewsItem(context: context)
        favoriteNews.newsAuthor = news?.author
        favoriteNews.newsContent = news?.content
        favoriteNews.newsImage = news?.image
        favoriteNews.newsDescription = news?.description
        favoriteNews.newsPublishDate = news?.publishDate
        favoriteNews.newsTitle = news?.title
        favoriteNews.newsUrlLink = news?.urlLink

        do {
            try context.save()

        } catch {
            print(NAError.coreDataError)
        }
    }
    
    func deleteFav(_ title: String) {
        persistanceManager.deleteFavoriteNewsItemDescription(title)
    }

    func checkIsNewsFavorite(completion: @escaping((Bool) -> Void)) {
        persistanceManager.checkNewsItemData(with: news.title ?? "Unknown Title") { (response) in
            switch response {
            case .success(let isFavorite):
                completion(isFavorite)
            case .failure(let error):
                print(error)
            }
        }
    }
}

