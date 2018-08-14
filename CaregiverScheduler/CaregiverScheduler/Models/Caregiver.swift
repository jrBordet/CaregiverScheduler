//
//  Caregiver.swift
//  CaregiverScheduler
//
//  Created by Jean Raphael on 13/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let results: [Caregiver]
}

struct Caregiver: Codable, Equatable {
    let name: Name
    let picture: Picture
    let login: Login
}

extension Caregiver {
    func imageUrl() -> URL? {
        guard let url = URL(string: picture.large) else { return nil }
        
        return url
    }
}

struct Name: Codable, Equatable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Codable, Equatable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Login: Codable, Equatable {
    let  uuid: String
}
