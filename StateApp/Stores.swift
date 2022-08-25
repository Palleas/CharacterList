//
//  Stores.swift
//  StateApp
//
//  Created by Romain Pouclet on 2022-08-25.
//

import Foundation
import Boutique

extension Store where Item == Character {
    
    static let characters = Store(storage: SQLiteStorageEngine.default)
    
}
