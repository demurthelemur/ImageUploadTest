//
//  ImageModel.swift
//  Image Download Test
//
//  Created by Demir Dereli on 28.08.2023.
//

import Foundation

struct ImageModel: Identifiable, Codable {
    let albumID: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailURL: String
    
    static let devInstance = ImageModel()
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id
        case title
        case url
        case thumbnailURL = "thumbnailUrl"
    }
    
    private init() {
        self.id = 1
        self.albumID = 1
        self.title = "Test"
        self.url = "https://via.placeholder.com/600/92c952"
        self.thumbnailURL = "https://via.placeholder.com/150/92c952"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumID = try container.decode(Int.self, forKey: .albumID)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
    }
}
