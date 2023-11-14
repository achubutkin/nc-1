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
        let schema = Schema([
            SwiftComponent.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}

var memoryOnlyModelContainer: ModelContainer = {
    let schema = Schema([
        SwiftComponent.self
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    
    do {
        let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        Task { @MainActor in
            let context = container.mainContext
            
            (0...9).forEach({ index in
                context.insert(SwiftComponent(timestamp: Date.now))
            })
        }
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
