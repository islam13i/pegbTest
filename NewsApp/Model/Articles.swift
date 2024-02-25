//
//  Articles.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import Foundation

struct Articles: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let urlLink: String?
    let image: String?
    let publishDate: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case urlLink = "url"
        case image = "urlToImage"
        case publishDate = "publishedAt"
        case content = "content"
    }
}
