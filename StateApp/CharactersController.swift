//
//  CharactersController.swift
//  StateApp
//
//  Created by Romain Pouclet on 2022-08-25.
//

import Foundation
import Boutique
import os.log

final class CharactersController: ObservableObject {

    @Stored(in: .characters) var characters: [Character]
    
    @Published var query: String = ""
    
    @Published var onlyShowCools: Bool = false

    let client = RandomUserClient()
    
    @MainActor
    func addCharacter() async {
        do {
            let newUsers = try await client.fetchUsers().map { randomUser in
                Character(name: randomUser.fullName, isCool: Bool.random())
            }
            
            try await $characters.add(newUsers)
        } catch let error {
            os_log(.error, "Unable to fetch new users: \(error.localizedDescription)")
        }
    }
}
