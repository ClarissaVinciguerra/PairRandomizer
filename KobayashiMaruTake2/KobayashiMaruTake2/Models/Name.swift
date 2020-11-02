//
//  Name.swift
//  KobayashiMaruTake2
//
//  Created by Clarissa Vinciguerra on 11/2/20.
//

import Foundation

class Name: Codable {
    let name: String
    let date: Date
    
    init(name: String, date: Date = Date()) {
        self.name = name
        self.date = date
    }
}

extension Name: Equatable {
    static func == (lhs: Name, rhs: Name) -> Bool {
        return lhs.name == rhs.name && lhs.date == rhs.date
    }
}
