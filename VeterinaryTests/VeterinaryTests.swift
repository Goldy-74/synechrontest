//
//  VeterinaryTests.swift
//  VeterinaryTests
//
//  Created by Apple on 25/06/22.
//

import XCTest
@testable import Veterinary

class VeterinaryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConfiguration(){
        let vm = HomeViewModel()
        let expect = expectation(description: "callWebServiceForGetConfiguration")
        vm.callWebServiceForGetConfiguration()
        vm.configurationSettings.bind { set in
            if let _ = set {
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 15.0, handler: nil)
    }
    
    func testPetLists(){
        let vm = HomeViewModel()
        let expect = expectation(description: "callWebServiceForGetPetList")
        vm.callWebServiceForGetPetList()
        vm.arrPets.bind { set in
            if let _ = set {
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 15.0, handler: nil)
    }

}
