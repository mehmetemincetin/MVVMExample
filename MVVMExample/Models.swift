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
    var username = "KanyeWest"
    
    
    init(name: String,
         middlename: String? = nil)
    {
        self.name = name
    }
}
