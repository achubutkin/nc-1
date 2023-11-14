//
//  ContentView.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 14/11/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [SwiftComponent]
    
    @State var searchComponentText = ""

    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    
                } footer: {
                    Text("Learn how to use and customize system-defined components to give people a familiar and consistent experience.")
                }
                
                Section {
                    ForEach(items) { item in
                        NavigationLink(item.timestamp.description) {
                            DetailsView()
                        }
                    }
                    .onDelete(perform: deleteItems)
                } header: {
                    Text("Basic components")
                }
                
                Section {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteItems)
                } header: {
                    Text("Advanced components")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .searchable(text: $searchComponentText, prompt: "Type component name")
            .navigationTitle("Swift UI")
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = SwiftComponent(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(memoryOnlyModelContainer)
}
