//
//  ContentView.swift
//  ColorHub
//
//  Created by Ankang Yang on 2024/2/29.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var colorPalettes: [ColorPalette]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(colorPalettes) { colorPalette in
                    NavigationLink {
                        ColorPaletteView(colorPalette:colorPalette)
                    } label: {
                        Text(colorPalette.name)
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(appContainer)
//}
