//
//  MangaAPIProtocol.swift
//  MangaPocket
//
//  Created by Jean Raphael on 20/07/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

protocol EmpaticaAPIProtocol {
    func fetchCaregivers(_ seed: String, resuts: Int) -> Observable<[Caregiver]>
}
