//
//  ColorHubApp.swift
//  ColorHub
//
//  Created by Ankang Yang on 2024/2/29.
//

import SwiftUI
import SwiftData

@main
struct ColorHubApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(appContainer)
    }
}
