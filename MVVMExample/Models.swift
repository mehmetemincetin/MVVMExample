//
//  Models.swift
//  MVVMExample
//
//  Created by Mehmet Emin Çetin on 15.07.2025.
//

import Foundation
 
enum Gender {
    case male, female, unspecified
}

struct Person {
    let name: String
    let birthdate: Date?
    let middlename: String?
    let address: String?
    let gender: Gender
    
    var username = "KanyeWest"
    
    init(name: String,
         birthdate: Date? = nil,
         middlename: String? = nil,
         address: String? = nil,
         gender: Gender = .unspecified)
    {
        self.name = name
        self.birthdate = birthdate
        self.middlename = middlename
        self.address = address
        self.gender = gender
    }
}
