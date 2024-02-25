//
//  NewsModel.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import Foundation

struct NewsModel: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}
