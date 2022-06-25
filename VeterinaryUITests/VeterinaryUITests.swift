//
//  VeterinaryUITests.swift
//  VeterinaryUITests
//
//  Created by Apple on 25/06/22.
//

import XCTest

class VeterinaryUITests: XCTestCase {
    var app: XCUIApplication! = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    
    func testUI(){
        
        let btnChat = app.buttons["Chat"]
        
        XCTAssertTrue(btnChat.waitForExistence(timeout: 20))
        
        if btnChat.isHittable {
            btnChat.tap()
            app.alerts["Alert!"].buttons["Ok"].tap()
            
            let btnCall = app.buttons["Call"]
            btnCall.tap()
            app.alerts["Alert!"].buttons["Ok"].tap()
            
            
            let firstCell = app.tables.cells.firstMatch
            
            firstCell.tap()
            
            let btnClose = app.buttons["Close"]
            
            btnClose.tap()

        }
        
                
    }
}
