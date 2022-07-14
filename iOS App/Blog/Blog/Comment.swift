//
//  Comment.swift
//  Blog
//
//  Created by Aiden Forrest on 13/07/2022.
//

import Foundation


struct Comment:Codable{
    let author: String
    let text: String
    let approved_comment: Bool
}

