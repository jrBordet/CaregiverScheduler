//
//  EmpaticaAPITests.swift
//  CaregiverSchedulerTests
//
//  Created by Jean Raphael on 13/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import XCTest
@testable import CaregiverScheduler

import Moya
import Alamofire

class EmpaticaServiceTests: XCTestCase {
    let results_per_page = 100
    
    let provider = MoyaProvider<EmpaticaService>(plugins: [NetworkLoggerPlugin()])

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_when_fetch_caregivers_list_successfully() {
        let expectation = XCTestExpectation(description: "Fetch caregivers list")
                
        provider
            .request(.users(seed: "empatica", results: results_per_page)) { result in
                switch result {
                case let .success(moyaResponse):
                    let statusCode = moyaResponse.statusCode
                    
                    XCTAssertEqual(statusCode, 200)
                    
                    do {
                        try _ = moyaResponse.filterSuccessfulStatusCodes()
                        
                        let careGivers = try JSONDecoder().decode(Results.self, from: moyaResponse.data)
                        
                        XCTAssertEqual(careGivers.results.count, self.results_per_page)
                    }
                    catch {
                        assertionFailure(error.localizedDescription)
                    }
                    
                    expectation.fulfill()
                    
                case let .failure(error):
                    assertionFailure(error.localizedDescription)
                    
                    expectation.fulfill()
                    break
                }
        }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
}
