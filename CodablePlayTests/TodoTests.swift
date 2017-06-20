//
//  TodoTests.swift
//  CodablePlayTests
//
//  Created by Steve Baker on 6/19/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import CodablePlay

class TodoTests: XCTestCase {

    func testInit() {
        let todo = Todo(title: "foo",
                        id: 3,
                        userId: 2,
                        completed: 5)

        XCTAssertEqual(todo.title, "foo")
        XCTAssertEqual(todo.id, 3)
        XCTAssertEqual(todo.userId, 2)
        XCTAssertEqual(todo.completed, 5)
    }
    
}
