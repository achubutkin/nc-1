//
//  Swifter_for_SwiftUIApp.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct Swifter_for_SwiftUIApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            AllComponentsView()
                .environment(modelData)
        }
        .modelContainer(sharedModelContainer)
    }
}

var memoryOnlyModelContainer: ModelContainer = {
    let schema = Schema([])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    do {
        let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        Task { @MainActor in
            let context = container.mainContext
            
            /*
            (0...9).forEach({ index in
                context.insert(SwiftComponent(timestamp: Date.now, title: "Component's title \(index)"))
            })
            */
        }
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()

// Create a struct to represent your JSON data
struct Item: Codable {
    let id: Int
    let name: String
}

class DataLoader: ObservableObject {
    @Published var items: [Item] = []

    func loadData() async {
        do {
            if let fileURL = Bundle.main.url(forResource: "SwiftUIComponents", withExtension: "json") {
                let data = try Data(contentsOf: fileURL)
                let decodedData = try JSONDecoder().decode([Item].self, from: data)
                DispatchQueue.main.async {
                    self.items = decodedData
                }
            }
        } catch {
            print("Error loading data: \(error.localizedDescription)")
        }
    }
}
