//
//  TodoJSONSerialization.swift
//  CodablePlay
//
//  Created by Steve Baker on 6/19/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import Foundation

/// Todo for use with JSONSerialization, popular before Codable
struct TodoOld {
    var title: String
    var id: Int?
    var userId: Int
    var completed: Int

    init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
            let id = json["id"] as? Int,
            let userId = json["userId"] as? Int,
            let completed = json["completed"] as? Int else {
                return nil
        }
        self.title = title
        self.userId = userId
        self.completed = completed
        self.id = id
    }
}
