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
        let colorpalettes = try LoadDatasetFromJSON()
        for item in colorpalettes{
            container.mainContext.insert( item )
        }
        return container
    }catch{
        fatalError("Failed to create container")
    }
}()


func LoadDatasetFromJSON() throws -> [ColorPalette] {
    var colorpalettes = [ColorPalette]()
    guard let url = Bundle.main.url(forResource: "dataset", withExtension: "json") else {
        fatalError("Failed to find dataset.json")
    }
    let jsonString = try String(contentsOf: url)
    guard let data = try? JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []),
              let topDictionary = data as? [String: Any],
              let itemArray = topDictionary["palettes"] as? [Any] else {
            fatalError("JSONSerialization Fail")
    }
    for item in itemArray{
        if let innerDictionary = item as? [String: Any],
           let name = innerDictionary["name"] as? String,
           let colorsArray = innerDictionary["colors"] as? [Any],
           let memo = innerDictionary["memo"] as? String
        {
            var paletteColors = [PaletteColor]()
            for color in colorsArray {
                if let innerData = color as? [String: Double],
                   let red = innerData["red"],
                   let green = innerData["green"],
                   let blue = innerData["blue"] 
                {
                    paletteColors.append(PaletteColor(red: red, green: green, blue: blue))
                }
            }
            colorpalettes.append(ColorPalette(name: name, colors: paletteColors, memo: memo))
        }
    }
    return colorpalettes
}
