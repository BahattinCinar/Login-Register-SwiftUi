//
//  user.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 5/27/24.
//

import Foundation

struct user: Identifiable, Codable{
    let id:String
    let fullName: String
    let email: String
    let phoneNum: String
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension user{
    static var MOCK_USER = user(id: NSUUID().uuidString, fullName: "test1", email: "test1@test.com", phoneNum: "1112223344")
}
