//
//  Models.swift
//  StateApp
//
//  Created by Romain Pouclet on 2022-08-25.
//

import Foundation

struct Character: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let isCool: Bool
    
    init(id: String = UUID().uuidString, name: String, isCool: Bool) {
        self.id = id
        self.name = name
        self.isCool = isCool
    }
}
