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
    let mal_id: Int
    let images: Images
    let title: String
//    let status: String
//    let prop: Prop?
//    let synopsis: String
//    let authors: [Author]
    let genres: [Genre]
//    let demographics: [Demographic]
}

struct Images: Codable {
    let jpg: ImageFormat?
    let webp: ImageFormat?
}

struct ImageFormat: Codable {
    let image_url: String?
}

//struct Prop: Codable {
//    let mangaYear: MangaYear
//}
//
//struct MangaYear: Codable {
//    let year: Int
//}
//
//struct Author: Codable {
//    let name: String
//}
struct Genre: Codable {
    let name: String
}

//struct Demographic: Codable {
//    let name: String
//}
