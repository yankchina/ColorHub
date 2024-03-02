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
    
    var red: Double
    var green: Double
    var blue: Double

    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.red = try container.decode(Double.self, forKey: .red)
        self.green = try container.decode(Double.self, forKey: .green)
        self.blue = try container.decode(Double.self, forKey: .blue)
    }
    
    var color: Color{
        Color(red: self.red / 2.56 , green: self.green / 2.56 , blue: self.blue / 2.56 )
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
