//
//  TodoManagerOldTests.swift
//  CodablePlayTests
//
//  Created by Steve Baker on 6/19/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import CodablePlay

class TodoManagerOldTests: XCTestCase {
    
    func testUrlForID() {
        XCTAssertEqual(TodoManager.endpointForID(5), "https://jsonplaceholder.typicode.com/todos/5")
    }

}
