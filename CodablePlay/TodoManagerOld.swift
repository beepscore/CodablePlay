//
//  TodoManagerOld.swift
//  CodablePlay
//
//  Created by Steve Baker on 6/19/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import Foundation

/// TodoManagerOld for use with JSONSerialization, popular before Codable
class TodoManagerOld {

    static func endpointForID(_ id: Int) -> String {
        return "https://jsonplaceholder.typicode.com/todos/\(id)"
    }

    static func todoByID(_ id: Int, completionHandler: @escaping (TodoOld?, Error?) -> Void) {

        // set up URLRequest with URL
        let endpoint = TodoManagerOld.endpointForID(id)
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)

        // Make request
        let session = URLSession.shared

        /// https://developer.apple.com/documentation/foundation/urlsession/1410330-datatask
        let taskCompletionHandler: (Data?, URLResponse?, Error?) -> Void = {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }

            // parse the result as JSON
            // then create a TodoOld from the JSON
            do {
                if let todoJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                    let todo = TodoOld(json: todoJSON) {
                    // created a TODO object
                    completionHandler(todo, nil)
                } else {
                    // couldn't create a todo object from the JSON
                    let error = BackendError.objectSerialization(reason: "Couldn't create a todo object from the JSON")
                    completionHandler(nil, error)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        }

        let task = session.dataTask(with: urlRequest, completionHandler: taskCompletionHandler)
        task.resume()
    }

    func getTodoOld(_ idNumber: Int) {
        TodoManagerOld.todoByID(idNumber, completionHandler: { (todo, error) in
            if let error = error {
                // got an error in getting the data, need to handle it
                print(error)
                return
            }
            guard let todo = todo else {
                print("error getting first todo: result is nil")
                return
            }
            // success :)
            debugPrint(todo)
            print(todo.title)
        })
    }

}
