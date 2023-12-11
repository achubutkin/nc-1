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

    @State private var searchComponentText = ""
    @State private var selectedComponents: Set<Component.ID> = []
    @State private var selectedComponent: Component?

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
                            let locked = component.locked ?? false
                            
                            NavigationLink {
                                if locked {
                                    VStack {
                                        Text(component.name)
                                            .font(.title3)
                                        Text("Not implemeted. Please, see List or Button components.")
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    }
                                }
                                else {
                                    DetailsView(component: component, componentDetails: modelData.componentDetails)
                                        .onAppear {
                                            modelData.loadComponentDetails(name: component.name)
                                            selectedComponent = component
                                        }
                                }
                            } label: {
                                HStack {
                                    Text(component.name)
                                        .accessibilityLabel("\(component.name) Component item. Open to read full description of this component.")
            
                                    if locked {
                                        Spacer()
                                        Image(systemName: "lock")
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text(group.name)
                    }
                }
            }
            .searchable(text: $searchComponentText, prompt: "Type component name")
            .navigationTitle("Swift UI")
        }
            /*
            let locked = component.locked ?? false
            
            if locked {
                VStack {
                    Text(component.name)
                        .font(.title3)
                    Text("Not implemeted. Please, see List or Button components.")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            else {
                DetailsView(component: component, componentDetails: modelData.componentDetails)
                    .onAppear {
                        modelData.loadComponentDetails(name: component.name)
                    }
            }
            */
    }
}

#Preview {
    AllComponentsView()
        .modelContainer(memoryOnlyModelContainer)
        .environment(ModelData())
}
