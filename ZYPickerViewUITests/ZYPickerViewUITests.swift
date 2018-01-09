//
//  ZYPickerViewUITests.swift
//  ZYPickerViewUITests
//
//  Created by 杨志远 on 2017/12/29.
//  Copyright © 2017年 BaQiWL. All rights reserved.
//

import XCTest

class ZYPickerViewUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSingleDataWithoutDefaultIndex() {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["7"]/*[[".pickers.pickerWheels[\"7\"]",".pickerWheels[\"7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.toolbars.buttons["完成"].tap()
    }
    
    func testSingleDataWithDefaultIndex() {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["9"].press(forDuration: 0.5);/*[[".pickers.pickerWheels[\"9\"]",".tap()",".press(forDuration: 0.5);",".pickerWheels[\"9\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        app.toolbars.buttons["完成"].tap()
    }
    
    func testMultiDataWithoutDefaultIndex() {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["7"]/*[[".pickers.pickerWheels[\"7\"]",".pickerWheels[\"7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app/*@START_MENU_TOKEN@*/.pickerWheels["4"]/*[[".pickers.pickerWheels[\"4\"]",".pickerWheels[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["1"]/*[[".pickers.pickerWheels[\"1\"]",".pickerWheels[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.toolbars.buttons["完成"].tap()
    }
    
    func testMultiDataWithDefaultIndex() {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["1"]/*[[".pickers.pickerWheels[\"1\"]",".pickerWheels[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.toolbars.buttons["完成"].tap()
    }
    
}
