//
//  DataManagerProtocol.swift
//  CaregiverScheduler
//
//  Created by Jean Raphael on 13/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import Foundation

import RxSwift

protocol DataManagerProtocol {
    func saveCaregivers(cg: [Caregiver])
    
    func retrieveAllCaregivers() -> Observable<[Caregiver]>
}
