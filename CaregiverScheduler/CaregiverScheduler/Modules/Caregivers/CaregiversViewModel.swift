//
//  CaregiversViewModel.swift
//  CaregiverSchedulerTests
//
//  Created by Jean Raphael on 13/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import Action

import RxDataSources

class CaregiversViewModel {
    let bag = DisposeBag()
    
    // MARK: - Output
    
    let caregiversCollection: Observable<[Caregiver]>
    
    var fetchCaregivers: Action<(Bool), [Caregiver]>!
    
    // MARK: - Initializer
    
    init(input i: (seed: String, results: Int), dependecy: (dataManager: DataManagerProtocol, api: EmpaticaAPIProtocol)) {
        let API = dependecy.api
        let manager = dependecy.dataManager
        
        self.caregiversCollection = API.fetchCaregivers(i.seed, resuts: i.results)
        
        self.fetchCaregivers = Action { action -> Observable<[Caregiver]> in
            return dependecy.dataManager.isDataSaved ?
                dependecy.dataManager.retrieveAllCaregivers() :
                API.fetchCaregivers(i.seed, resuts: i.results)
        }
        
        self.fetchCaregivers
            .elements
            .subscribe(onNext: { caregivers in
                dependecy.dataManager.saveCaregivers(cg: caregivers)
            }).disposed(by: bag)
    }
}
