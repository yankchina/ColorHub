//
//  AppContainer.swift
//  ColorHub
//
//  Created by Ankang Yang on 2024/2/29.
//

import Foundation
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        let schema = Schema([
            ColorPalette.self,
            PaletteColor.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let container = try ModelContainer( for: schema, configurations: modelConfiguration )
        
        // loading `colorpalletes.json`
        try container.mainContext.delete(model:ColorPalette.self)
        guard let url = Bundle.main.url(forResource: "colorpalettes", withExtension: "json") else{
            fatalError("Failed to find json file")
        }
        let data = try Data(contentsOf: url)
        let colorpallettes = try JSONDecoder().decode([ColorPalette].self, from: data)
        for item in colorpallettes{
            container.mainContext.insert(item)
        }
        print("JSON Loaded")
        return container
    }catch{
        fatalError("Failed to create container")
    }
}()
