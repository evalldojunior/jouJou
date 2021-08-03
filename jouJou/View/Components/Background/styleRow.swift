//
//  styleRow.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 22/07/21.
//

import SwiftUI

struct styleRow: View {
    var type: String
    var icon: String
    
    var body: some View {
        HStack{
            Text(type)
                .font(Font.custom("Raleway-Regular", size: 13))
            Spacer()
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }.frame(width: 254, height: 70)
    }
}

struct styleRow_Previews: PreviewProvider {
    static var previews: some View {
        styleRow(type: "Papel liso", icon: "icone-papel-liso")
    }
}
