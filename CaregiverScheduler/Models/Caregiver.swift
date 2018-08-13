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

struct Caregiver: Decodable {
    let name: Name
    let picture: Picture
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
