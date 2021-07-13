//
//  Canvas.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 13/07/21.
//

import Foundation
import SwiftUI

struct Canvas: View {
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 29) {
                        
                        // image
                        Button(action: {
                            // add image action
                        }, label: {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 37, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // song
                        Button(action: {
                            // add song action
                        }, label: {
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // pencil
                        Button(action: {
                            // add pencil action
                        }, label: {
                            Image(systemName: "pencil.and.outline")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // stiker
                        Button(action: {
                            // add sticker action
                        }, label: {
                            Image(systemName: "seal")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // text
                        Button(action: {
                            // add text action
                        }, label: {
                            Image(systemName: "textformat")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // question
                        Button(action: {
                            // add question action
                        }, label: {
                            Image(systemName: "note.text.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // ckecklist
                        Button(action: {
                            // add checklist action
                        }, label: {
                            Image(systemName: "checkmark.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // ckecklist
                        Button(action: {
                            // add checklist action
                        }, label: {
                            Image(systemName: "wand.and.stars")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        })
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.beigeColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas()
    }
}
