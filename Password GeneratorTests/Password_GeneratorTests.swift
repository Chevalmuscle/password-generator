//
//  Password_GeneratorTests.swift
//  Password GeneratorTests
//
//  Created by Marc-Antoine Jean on 2020-04-13.
//  Copyright © 2020 Marc-Antoine Jean. All rights reserved.
//

import XCTest
@testable import Password_Generator

class Password_GeneratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetRandomPassword() throws {
        
        // the test is made by testing a lot of random password
        // because getRandomPassword() returns a random output
        
        let strongPasswordRegex = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$%?&*(){}\\[\\]])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{16}$"
        for _ in 1...20 {
            XCTAssertTrue(getRandomPassword().range(of: strongPasswordRegex, options: .regularExpression, range: nil, locale: nil) != nil, "Strong enough password")
        }
        
        let weakPasswordRegex = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$%?&*(){}\\[\\]])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        for _ in 1...20 {
            XCTAssertFalse(getRandomPassword().range(of: weakPasswordRegex, options: .regularExpression, range: nil, locale: nil) != nil, "Weak password")
        }
    }
    
    func testIsValidPassword() throws {
        // invalid length check
        XCTAssertThrowsError(try isValidPassword(password: "9knD({&2y}&*od2L", requiredLength: 0)) { error in
            XCTAssertEqual(error as! InvalidParameterError, InvalidParameterError.NonPositiveIntError)
        }
        XCTAssertThrowsError(try isValidPassword(password: "9knD({&2y}&*od2L", requiredLength: -1)) { error in
            XCTAssertEqual(error as! InvalidParameterError, InvalidParameterError.NonPositiveIntError)
        }
        
        // valid password check
        XCTAssertTrue(try isValidPassword(password: "9knD({&2y}&*od2L", requiredLength: 16), "Valid password")
        XCTAssertTrue(try isValidPassword(password: "LA#Ds9Xx)o02&iYU", requiredLength: 16), "Valid password")
        XCTAssertTrue(try isValidPassword(password: "AB!12cde", requiredLength: 8), "Valid password")
        
        // required characters check
        XCTAssertFalse(try isValidPassword(password: "AB!12cde", requiredLength: 7), "Invalid password")
        XCTAssertFalse(try isValidPassword(password: "A!12cde", requiredLength: 7), "Invalid password")
        XCTAssertFalse(try isValidPassword(password: "AB12cde", requiredLength: 7), "Invalid password")
        XCTAssertFalse(try isValidPassword(password: "AB!1cde", requiredLength: 7), "Invalid password")
        XCTAssertFalse(try isValidPassword(password: "AB!12cd", requiredLength: 7), "Invalid password")
        
        // wrong password length check
        XCTAssertFalse(try isValidPassword(password: "", requiredLength: 7), "Invalid password")
        XCTAssertFalse(try isValidPassword(password: "AB!12cde", requiredLength: 2), "Invalid password")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
