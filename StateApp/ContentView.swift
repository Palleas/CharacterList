//
//  ContentView.swift
//  StateApp
//
//  Created by Romain Pouclet on 2022-08-25.
//

import SwiftUI
import Boutique
import os.log

struct ContentView: View {
    @ObservedObject var controller = CharactersController()
    
    @State var characters: [Character] = []
    
    var body: some View {
        VStack {
            Button("Add User") {
                Task {
                    await controller.addCharacter()
                }
            }
            
            Form {
                Section("Filter") {
                    TextField("Name", text: $controller.query)
                    Toggle("Only show cool characters", isOn: $controller.onlyShowCools)
                }
            }
            
            List(characters) { character in
                HStack {
                    Image(systemName: "person.fill").foregroundColor(character.isCool ? .green : .red)
                    Text(character.name)
                }
            }
        }
        .onReceive(controller.$characters.$items, perform: { characters in
            self.characters = characters.filter { character in
                (controller.onlyShowCools ? character.isCool : true) && (controller.query.isEmpty ? true : character.name.contains(controller.query))
            }
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
