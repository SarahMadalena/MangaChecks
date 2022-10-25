//
//  ResultMangasModel.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 21/10/22.
//

import Foundation

struct Result: Decodable {
    let data: [MangasData]
}

struct MangasData: Codable {
    let malID: Int //criar exceção
    let images: Images
    let title: String
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case images, title
        case genres
    }
}

struct Images: Codable {
    let jpg: ImageFormat?
    let webp: ImageFormat?
}

struct ImageFormat: Codable {
    let imageURL: String?
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
struct Genre: Codable {
    let name: String
}
