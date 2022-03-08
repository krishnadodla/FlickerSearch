//
//  ImageSearchModel.swift
//  FlickerSearch
//
//  Created by kdodla on 3/7/22.
//

import Foundation

protocol BaseModel: Codable {
    
}

struct ImageSearchModel: BaseModel {
    var link: String?
    var description: String?
    var modified: String?
    var generator: String?
    var items: [Items]?
    
    enum CodingKeys: String, CodingKey {
        case link
        case description
        case modified
        case generator
        case items
    }
}

struct Items: BaseModel {
    var title: String?
    var itemLink: String?
    var media: Media?
    var dateTaken: String?
    var description: String?
    var published: String?
    var author: String?
    var authorId: String?
    var tags: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case itemLink = "link"
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case authorId = "author_id"
        case tags
    }
}

struct Media: BaseModel {
    var mediaLink: String?
    
    enum CodingKeys: String, CodingKey {
        case mediaLink = "m"
    }
}
