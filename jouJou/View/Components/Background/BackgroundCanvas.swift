//
//  BackgroundCanvas.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 29/07/21.
//

import Foundation
import SwiftUI

struct BackgroundCanvas: View {
    var type: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if type != "Papel-Liso" {
                    
                    VStack (spacing: 29){
                        ForEach((0..<100), id: \.self) { _ in
                            Divider()
                                .frame(width: geometry.size.width)
                                .background(Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 0.5999765965)))
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
//                    if type == "Papel-Quadriculado" {
//                        HStack (spacing: 29){
//                            ForEach((0..<50), id: \.self) { _ in
//                                Divider()
//                                    .frame(height: geometry.size.height)
//                                    .foregroundColor(Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)))
//                            }
//                        }
//                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.beigeColor.opacity(0.0001).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }
        
    }
}

struct BackgroundCanvas2: View {
    var type: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if type == "Papel-Quadriculado" {
                    HStack (spacing: 29){
                        ForEach((0..<50), id: \.self) { _ in
                            Divider()
                                .frame(height: geometry.size.height)
                                .background(Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 0.5999765965)))
                        }
                    }
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.beigeColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }
        
    }
}

struct BackgroundCanvas_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCanvas(type: "Papel-Quadriculado")
    }
}
