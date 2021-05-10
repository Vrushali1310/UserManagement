//
//  UserServiceManager.swift
//  UserList_Webguru
//
//  Created by Vrushali Mahajan on 5/10/21.
//

import UIKit
import CoreData


class UserServiceManager: NSObject {
    
    static var shared: UserServiceManager = UserServiceManager()
    
    private override init() { }
    
    private let getUsersURL = "https://5ec4c2c0628c160016e71369.mockapi.io/users"
    
    var usersArray: [User] = []
    
    func getUsersList(onSuccess: @escaping() -> Void, onFailure: @escaping(String, String?) -> Void) {
        
        let requestObject = RequestModel(url: getUsersURL, httpMethod: .GET, headerFields: nil, httpBody: nil)
        
        ServerManager.shared.dataTask(requestObject: requestObject) { [unowned self] (responseModel) in
            
            if responseModel?.statusCode == 200 {
                if let data = responseModel?.data {
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        self.usersArray = users
                        onSuccess()
                    } catch {
                        print(error)
                        onFailure(error.localizedDescription, nil)
                    }
                }
            } else if responseModel?.statusCode == 400 {
                onFailure("Bad Request", "The server cannot or will not process the request due to an apparent client error.")
            } else if responseModel?.statusCode == 404 {
                onFailure("Not Found", "The requested resource could not be found but may be available in the future")
            } else {
                onFailure(responseModel?.error.debugDescription ?? "Error occured. Please retry.", nil)
            }
            
        }
    }
    
    func addUser(userDict: [String: String], onSuccess: @escaping() -> Void, onFailure: @escaping(String, String?) -> Void) {
                
        let requestObject = RequestModel(url: getUsersURL, httpMethod: .POST, headerFields: nil, httpBody: userDict)
        
        ServerManager.shared.dataTask(requestObject: requestObject) { [unowned self] (responseModel) in
            
            if responseModel?.statusCode == 201 {
                if let data = responseModel?.data {
                    
                    do {
                        
                        let responseObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
                                                
                        if let responseDict = responseObject, let userDict = responseDict["items"] as? [String: String] {
                            
                            let user = User(from: userDict)
                            self.usersArray.append(user)
                        }
                        onSuccess()
                    } catch {
                        print(error)
                        onFailure(error.localizedDescription, nil)
                    }
                }
            } else if responseModel?.statusCode == 400 {
                onFailure("Bad Request", "The server cannot or will not process the request due to an apparent client error.")
            } else if responseModel?.statusCode == 404 {
                onFailure("Not Found", "The requested resource could not be found but may be available in the future")
            } else {
                onFailure(responseModel?.error.debugDescription ?? "Error occured. Please retry.", nil)
            }
        }
    }
}
