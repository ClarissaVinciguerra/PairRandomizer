//
//  PersonController.swift
//  KobayashiMaruTake2
//
//  Created by Clarissa Vinciguerra on 11/2/20.
//

import Foundation

class NameController {
    // MARK: - Properties
    static let shared = NameController()
    var namesArray: [Name] = []
    
    // MARK: - CRUD Functions
    // Create
    func addNameToArray(name: String) {
        let newName = Name(name: name)
        namesArray.append(newName)
        print("NewName: \(newName.name)")
        saveToPersistenceStore()
    }
    
    func deleteName(nameToDelete: Name) {
        guard let index = namesArray.firstIndex(of: nameToDelete) else { return }
        namesArray.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    func createPersistenceStore() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("KobayashiMaruTake2.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(namesArray)
            try data.write(to: createPersistenceStore())
        } catch {
            print("======== ERROR =======")
            print("There was an error encoding names into data. \nError in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            print("======== ERROR =======")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            namesArray = try JSONDecoder().decode([Name].self, from: data)
        } catch {
            print("======== ERROR =======")
            print("There was an error encoding data. \nError in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            print("======== ERROR =======")
        }
    }
} // End of Class
