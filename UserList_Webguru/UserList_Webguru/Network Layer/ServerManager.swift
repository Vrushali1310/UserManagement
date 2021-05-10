//
//  ServerManager.swift
//  UserList_Webguru
//
//  Created by Vrushali Mahajan on 5/10/21.
//

import UIKit


/// HTTP method type
enum HTTPMethod {
    case GET,POST,DELETE,PUT
    var value : String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .DELETE:
            return "DELETE"
        case .PUT:
            return "PUT"
        }
    }
}

final class ServerManager: NSObject {
    
    static var shared = ServerManager()
        
    private override init() { }

    
    typealias CompletionHandler = ((_ response : ResponseModel?) -> Void)
    
    func dataTask(requestObject: RequestModel, completionHandler:@escaping CompletionHandler) {
        
        guard let stringURL = requestObject.url,let serverURL = URL(string: stringURL) else {
            return
        }
        var urlRequest = URLRequest(url: serverURL)
        urlRequest.httpMethod = requestObject.httpMethod.value
        
        if let body = requestObject.httpBody {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch {
                return
            }
        }

        urlRequest.allHTTPHeaderFields = requestObject.headerFields
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data,response,error) in
            if let responseObject = response as? HTTPURLResponse {
                print("statusCode : " + responseObject.statusCode.description)
                let responseModel = ResponseModel(statusCode: responseObject.statusCode, error: error, data: data)
                completionHandler(responseModel)
                return
            }
            completionHandler(nil)
        })
        task.resume()
    }
}

/// Request generate model
struct RequestModel {
    let url: String?
    var httpMethod: HTTPMethod = .GET
    var headerFields: [String : String]? = nil
    var httpBody: [String : Any]? = nil
}

/// Response model
struct ResponseModel {
    let statusCode : Int
    let error : Error?
    let data : Data?
}
