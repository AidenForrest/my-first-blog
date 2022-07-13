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
    let created_date: String
    let published_date: String?
}
