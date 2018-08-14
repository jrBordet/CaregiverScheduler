//
//  DataManagerProtocolTests.swift
//  CaregiverSchedulerTests
//
//  Created by Jean Raphael on 13/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import XCTest
@testable import CaregiverScheduler

import RxSwift

class DataManagerProtocolTests: XCTestCase {
    
    let bag = DisposeBag()
    
    let dataManager: DataManagerProtocol = DataManager.shared
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        Storage.clear(.documents)
    }
    
    func test_when_save_caregiver() {
        let expectation = XCTestExpectation(description: "Caregivers collection")
        
        let expectedResult = Caregiver(name: Name(title: "mr", first: "lucas", last: "harcourt"),
                                       picture: Picture(large: "https://randomuser.me/api/portraits/men/41.jpg",
                                                        medium: "https://randomuser.me/api/portraits/med/men/41.jpg",
                                                        thumbnail: "https://randomuser.me/api/portraits/thumb/men/41.jpg"),
                                       login: Login(uuid: "963390eb-0ae2-404a-9b2f-27665a4e3a3a"))            
        
        dataManager.saveCaregivers(cg: [expectedResult])
        
        dataManager
            .retrieveAllCaregivers()
            .subscribe(onNext: { results in
                
                if let cg = results.first {
                    XCTAssertEqual(cg, expectedResult)
                }
                
                expectation.fulfill()
                
            }).disposed(by: bag)
        
        wait(for: [expectation], timeout: 60.0)
    }
}
