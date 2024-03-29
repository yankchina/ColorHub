//
//  ColorPalette.swift
//  ColorHub
//
//  Created by Ankang Yang on 2024/2/29.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class PaletteColor : Codable{
    
    enum CodingKeys: CodingKey{
        case red,green,blue
    }
    
    var red: Int
    var green: Int
    var blue: Int

    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.red = try container.decode(Int.self, forKey: .red)
        self.green = try container.decode(Int.self, forKey: .green)
        self.blue = try container.decode(Int.self, forKey: .blue)
    }
    
    var color: Color{
        Color(red: Double(self.red) / 255, green: Double(self.green) / 255, blue: Double(self.blue) / 255)
    }
    
    var rgbCode: String{
        "RGB(\(self.red),\(self.green),\(self.blue))"
    }
    
    func encode(to encoder: Encoder) throws{
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
    }
    
}

@Model
final class ColorPalette :Codable{
    
    enum CodingKeys : CodingKey{
        case name, colors, memo
    }
    
    var id: UUID
    var name: String
    var colors: [PaletteColor]
    var memo: String
    
    init(name: String, colors: [PaletteColor], memo: String) {
        self.id = UUID()
        self.name = name
        self.colors = colors
        self.memo = memo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.colors = try container.decode([PaletteColor].self, forKey: .colors)
        self.memo = try container.decode(String.self, forKey: .memo)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(colors, forKey: .colors)
        try container.encode(memo, forKey: .memo)
    }
}
