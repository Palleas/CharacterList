//
//  RandomUser.swift
//  StateApp
//
//  Created by Romain Pouclet on 2022-08-25.
//

import Foundation

struct RandomUserResponse: Decodable {
    let results: [RandomUser]
}

struct RandomUser: Decodable {
    struct Name: Decodable {
        let first: String
        let last: String
    }
    
    let name: Name
    
    var fullName: String {
        "\(name.first) \(name.last)"
    }
}

struct InvalidResponseError: Error {
    let response: URLResponse
}

struct RandomUserClient {
    func fetchUsers() async throws -> [RandomUser] {
        let (data, response) = try await URLSession.shared.data(from: URL(string: "https://randomuser.me/api/?inc=name")!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw InvalidResponseError(response: response)
        }
        
        return try JSONDecoder().decode(RandomUserResponse.self, from: data).results
    }
}
