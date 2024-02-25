//
//  Endpoint.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import Foundation

enum Endpoint {
    enum Constant {
        static let baseURL = "https://newsapi.org/v2"
        static let apiKey = "2c5d5f14f7a345e7a8bb3d6ff5903d97"
    }
    
    case topNews(page: Int)
    
    var url: URL? {
        switch self {
        case .topNews(let page):
            return URL(string: "\(Constant.baseURL)/top-headlines?country=us&page=\(page)&apiKey=\(Constant.apiKey)")
        }
    }
}
