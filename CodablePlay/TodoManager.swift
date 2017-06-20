//
//  TodoManager.swift
//  CodablePlay
//
//  Created by Steve Baker on 6/19/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import Foundation

class TodoManager {

    static func endpointForID(_ id: Int) -> String {
        return "https://jsonplaceholder.typicode.com/todos/\(id)"
    }

}
