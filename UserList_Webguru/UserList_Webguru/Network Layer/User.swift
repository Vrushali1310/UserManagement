//
//  User.swift
//  UserList_Webguru
//
//  Created by Vrushali Mahajan on 5/10/21.
//

import Foundation

struct User: Codable {
    
    var id: String
    var name: String
    var email: String
    var mobile: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case mobile = "mobile"
    }

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        mobile = try values.decode(String.self, forKey: .mobile)
    }
    
    init(from dict: [String: String])  {
        id = dict["id"] ?? ""
        name = dict["name"] ?? ""
        email = dict["email"] ?? ""
        mobile = dict["mobile"] ?? ""
    }
}
