//
//  ContentView.swift
//  Swifter for SwiftUI
//
//  Created by Alexandr Chubutkin on 14/11/23.
//

import SwiftUI
import SwiftData

struct AllComponentsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(ModelData.self) var modelData
 
    @Query private var items: [SwiftComponent]
    @State var searchComponentText = ""

    var body: some View {
        let filteredComponents: [Group] = modelData.allComponents.filter { group in
            searchComponentText.isEmpty || group.components.contains(where: { component in component.name.contains(searchComponentText) })
        }
       
        NavigationStack {
            List {
                Section {
                    
                } footer: {
                    Text("Learn how to use and customize system-defined components to give people a familiar and consistent experience.")
                }
                
                ForEach(filteredComponents) { group in
                    Section {
                        ForEach(group.components) { component in
                            NavigationLink {
                                DetailsView(component: component, componentDetails: modelData.componentDetails)
                                    .onAppear {
                                        modelData.loadComponentDetails(name: component.name)
                                    }
                            } label: {
                                Text(component.name)
                            }
                        }
                    } header: {
                        Text(group.name)
                    }
                }
                
                Section {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        } label: {
                            Text(item.title)
                        }
                    }
                    .onDelete(perform: deleteItems)
                } header: {
                    Text("Others")
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
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = SwiftComponent(timestamp: Date(), title: "")
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
    AllComponentsView()
        .modelContainer(memoryOnlyModelContainer)
        .environment(ModelData())
}
