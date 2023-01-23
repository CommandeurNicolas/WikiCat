//
//  CatImage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation

struct CatImage: Codable, Identifiable {
    let id: String
    let width: Int
    let height: Int
    let url: String
}
