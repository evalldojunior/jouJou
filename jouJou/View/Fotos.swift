//
//  Fotos.swift
//  jouJou
//
//  Created by Dara Caroline on 05/08/21.
//

import SwiftUI

struct Fotos: View {
    var images: [String] = ["exemplo2", "exemplo3", "exemplo2", "exemplo3", "exemplo2"]
    var mes = "Julho"
    var subtitles: [String] = ["gay rights", "a lua - Pabllo Vittar", "mais gays", "a lua me traiu", "chega de gays"]
    var days: [String] = ["13/07", "12/07", "11/07", "10/07", "09/07"]


    var body: some View {
        VStack(alignment: .leading){
            Text("algumasFotos \(mes)")
                .font(.custom("Raleway-Bold", size: 24))
                .foregroundColor(.blackColor)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 56)
                //.padding(.vertical)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<images.count, id: \.self) { index in
                        //gamby
                        if index == 0 {
                            Spacer().frame(width: 36)
                        }
                        
                        VStack() {
                            Image(images[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 186, height: 192, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10)
                            
                            Text(subtitles[index])
                                .font(.custom("Raleway-SemiBold", size: 14))
                                .foregroundColor(.blackColor)
                                .multilineTextAlignment(.center)
                            
                            Text(days[index])
                                .font(.custom("Raleway-Regular", size: 14))
                                .foregroundColor(.blackColor)
                                .multilineTextAlignment(.center)
                        }.frame(width: 190, height: 235, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }.frame(height: 250)
        }
        
    }
}

struct Fotos_Previews: PreviewProvider {
    static var previews: some View {
        Fotos()
    }
}
