//
//  PetResponseModel.swift
//  Veterinary
//
//  Created by Apple on 25/06/22.
//

import Foundation

// MARK: - PetResponseModel
struct PetResponseModel: Codable {
    let pets: [Pet]
}

// MARK: - Pet
struct Pet: Codable {
    let imageURL: String
    let title: String
    let contentURL: String
    let dateAdded: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case title
        case contentURL = "content_url"
        case dateAdded = "date_added"
    }
}
