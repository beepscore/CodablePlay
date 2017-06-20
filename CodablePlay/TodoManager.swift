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
    
    static func todoByID(_ id: Int, completionHandler: @escaping (Todo?, Error?) -> Void) {
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
        let task = session.dataTask(with: urlRequest, completionHandler: {
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
            // then create a Todo from the JSON
            let decoder = JSONDecoder()
            do {
                let todo = try decoder.decode(Todo.self, from: responseData)
                completionHandler(todo, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }

    func getTodo(_ idNumber: Int) {
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
