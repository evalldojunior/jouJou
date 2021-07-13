//
//  Canvas.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 13/07/21.
//

import Foundation
import SwiftUI

struct Canvas: View {
    @State var text = 0
    @State private var showingImagePicker = false
    @State private var showingImageOptions = false
    @State private var inputImage: UIImage?
    @State  var image: [Image] = []
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var numberOfImages = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                //imagens
                ForEach((0..<image.count), id: \.self) { i in
                    ImageView(image: image[i])
                }
                // textos
                ForEach((0..<text), id: \.self) { _ in
                    TextView()
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 29) {
                        
                        // image
                        Button(action: {
                            numberOfImages += 1
                            self.showingImageOptions = true
                        }) {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 37, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color.blueColor)
                        }    .actionSheet(isPresented: $showingImageOptions, content: {
                            ActionSheet(title: Text("Titulo"), message: Text("mensagem"), buttons: [
                                .default(Text("Câmera")) {
                                    sourceType = .camera
                                    showingImagePicker = true
                                },
                                .default(Text("Galeria")) {
                                    sourceType = .photoLibrary
                                    showingImagePicker = true
                                },
                                .cancel()
                            ])
                        })
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$inputImage, sourceType: sourceType)
                        }
                        
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
                            text += 1
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
    func loadImage() {
        guard let inputImage = inputImage else { return }
        var converted = Image(uiImage: inputImage)
          image.append(converted)
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas()
    }
}
