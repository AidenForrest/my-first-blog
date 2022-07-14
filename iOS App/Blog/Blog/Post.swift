//
//  Post.swift
//  Blog
//
//  Created by Aiden Forrest on 13/07/2022.
//

import Foundation


struct Post:Codable{
    let author: Int
    let title: String
    let text: String
    let createdDate: String?
    let publishedDate: String?
}

extension Post {
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case text
        case createdDate = "created_date"
        case publishedDate = "published_date"
    }
}
