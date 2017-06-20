//
//  Todo.swift
//  CodablePlay
//
//  Created by Steve Baker on 6/19/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import Foundation

// https://developer.apple.com/documentation/swift/codable?changes=latest_minor
struct Todo: Codable {
    var title: String
    var id: Int?
    var userId: Int
    var completed: Int
}
