//
//  DataManager.swift
//  MangaPocket
//
//  Created by Jean Raphael on 26/07/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import UIKit

import RxSwift

// https://krakendev.io/blog/the-right-way-to-write-a-singleton

class DataManager: DataManagerProtocol {
    static let shared = DataManager()

    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    // MARK: - DataManagerProtocol
    
    func saveCaregivers(cg: [Caregiver]) {
        Storage.store(cg, to: .documents, as: "caregivers.json")
    }
    
    func retrieveAllCaregivers() -> Observable<[Caregiver]> {
        return Observable<[Caregiver]>.create({ observer -> Disposable in
            
            let caregivers = Storage.retrieve("caregivers.json",
                                              from: .documents,
                                              as: [Caregiver].self)
            
            observer.onNext(caregivers)
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
    
}
