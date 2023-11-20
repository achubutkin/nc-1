//
//  ModelData.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 15/11/23.
//

import Foundation

@Observable
class ModelData {
    var allComponents: [Group] = []
    var componentDetails: ComponentDetails? = nil
    
    init() {
        loadAllComponents()
    }
    
    func loadAllComponents() {
        self.allComponents = load("AllComponents.json")
    }
    
    func loadComponentDetails(name: String) {
        self.componentDetails = load("\(name).json")
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

