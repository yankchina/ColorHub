//
//  ColorPaletteView.swift
//  ColorHub
//
//  Created by Ankang Yang on 2024/3/2.
//

import SwiftUI

struct ColorPaletteView: View {
    let colorPalette: ColorPalette

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack{
                Text("Name: \(colorPalette.name)")
                    .font(.headline)
                Text("Description: \(String(describing: colorPalette.memo))")
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 5) {
                ForEach(colorPalette.colors.indices, id: \.self) { index in
                    let item = colorPalette.colors[index]
                    HStack {
                        Rectangle()
                            .fill(item.color)
                            .frame(width: 50, height: 25)
                        Spacer()
                        Text("\(item.rgbCode)")
                    }
                }
            }
        }
    }
}

//#Preview {
//    ColorPaletteView(name:"demo",colors: [.init(red: 0.2, green: 0.64, blue: 0.35),
//                                          .init(red: 0.49, green: 0.71, blue: 0.58),
//                                          .init(red: 0.22, green: 0.64, blue: 0.35)
//    ], memo:"mddadada")
//}
