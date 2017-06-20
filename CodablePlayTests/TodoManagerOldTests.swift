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

    /// Asynchronous test
    /// https://developer.apple.com/documentation/xctest/asynchronous_tests_and_expectations/testing_asynchronous_operations_with_expectations
    /// Alternatively could use more verbose XCTWaiter and check it returns .completed
    /// http://masilotti.com/xctest-waiting/
    /// http://shashikantjagtap.net/asynchronous-ios-testing-swift-xcwaiter/
    func testTodoByID() {

        let expectation = XCTestExpectation(description: "download todo")

        let completionHandler = { (todo: TodoOld?, error: Error?) -> Void in
            if let error = error {
                // got an error in getting the data, need to handle it
                print(error)
                return
            }
            guard let todo = todo else {
                let failMessage = "error getting first todo: result is nil"
                XCTFail(failMessage)
                return
            }
            // success :)
            XCTAssertNotNil(todo, "No todo was downloaded.")

            debugPrint(todo)
            XCTAssertEqual(todo.title, "laboriosam mollitia et enim quasi adipisci quia provident illum")
            XCTAssertEqual(todo.id!, 5)

            expectation.fulfill()
        }

        // call method under test
        TodoManagerOld.todoByID(5, completionHandler: completionHandler)

        // wait until the expectation is fulfilled
        wait(for: [expectation], timeout: 10.0)
    }
}
