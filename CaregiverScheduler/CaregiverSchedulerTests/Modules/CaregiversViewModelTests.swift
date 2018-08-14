//
//  CaregiversViewModelTests.swift
//  CaregiverSchedulerTests
//
//  Created by Jean Raphael on 13/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import XCTest
@testable import CaregiverScheduler

import RxSwift

class CaregiversViewModelTests: XCTestCase {
    
    let bag = DisposeBag()
    
    var viewModel = CaregiversViewModel(input: (seed: "empatica", results: 10),
                                        dependecy: (dataManager: DataManager.shared, api: EmpaticaAPI()))
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_when_fetch_caregivers() {
        let expectation = XCTestExpectation(description: "Caregivers collection")

        viewModel
            .caregiversCollection
            .subscribe(onNext: { caregivers in
                debugPrint(caregivers)
                
                expectation.fulfill()
            }).disposed(by: bag)
        
        wait(for: [expectation], timeout: 60.0)
    }
}
