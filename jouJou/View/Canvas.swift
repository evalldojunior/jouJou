//
//  Canvas.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 13/07/21.
//

import Foundation
import SwiftUI
import PencilKit

struct Canvas: View {
    @State var text = 0
    @State private var showingImagePicker = false
    @State private var showingImageOptions = false
    @State private var inputImage: UIImage?
    @State  var image: [Image] = []
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var numberOfImages = 0
    @State private var drawingView = PKCanvasView()
    @State var pencilTapped = false
    @State var isPopoverPresented = false
    @State var StickersGrid = StickersGridView()
    let stickers = ["heart.circle", "bed.double.fill", "star.fill", "moon.stars.fill", "paperplane.fill", "person.fill", "suit.club.fill", "flag.fill", "smoke.fill", "mappin.circle.fill", "hifispeaker.fill", "photo.fill.on.rectangle.fill", "gift.fill"]
    @State var stickersTapped: [String] = []
    @State var conteudo: String = ""


    
    var body: some View {
        NavigationView {
            ZStack {
                //desenhos
                DrawingView(showingToolPicker: $pencilTapped, drawingView: $drawingView)
                //imagens
                ForEach((0..<image.count), id: \.self) { i in
                    ImageView(image: image[i])
                }
                //stickers
                ForEach((0..<stickersTapped.count), id: \.self) { k in
                    ImageView(image: Image(systemName:stickersTapped[k]))
                }
                //textos
                ForEach((0..<text), id: \.self) { _ in
                    TextView(conteudo: conteudo)
                        
                    
                }
                
            }  .onDrop(of: [.image, .text], isTargeted: nil) { providers in
                let dropController = ContentDropController(
                    images: $image,text: $text, conteudo: $conteudo)
                return dropController.receiveDrop(
                  itemProviders: providers)
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
                                .frame(width: 37, height: 30, alignment: .center)
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
                            
                        }, label: {
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        // pencil
                        Button(action: {
                            // add pencil action
                            pencilTapped.toggle()
                            
                        }, label: {
                            Image(systemName: "pencil.and.outline")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // sticker
                        Button(action: {
                            self.isPopoverPresented = true

                        }, label: {
                            Image(systemName: "seal")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        }).popover(isPresented: $isPopoverPresented) {
                            GeometryReader{ geo in
                            ScrollView{
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 3){
                                    ForEach(stickers, id: \.self){ post in
                                        Button(action: {
                                              stickersTapped.append(post)
                                            isPopoverPresented.toggle()
                                        }) {
                                            Image(systemName: post)
                                            .frame(width: geo.size.width/3, height: geo.size.width/3)
                                        }
                                    }
                                }
                            }
                        }
                                    .padding()
                                .frame(width: 280, height: 280)
                        }
                        
                        // text
                        Button(action: {
                            conteudo = ""
                            text += 1
                        }, label: {
                            Image(systemName: "textformat")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // question
                        Button(action: {
                            // add question action
                        }, label: {
                            Image(systemName: "note.text.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // ckecklist
                        Button(action: {
                            // add checklist action
                        }, label: {
                            Image(systemName: "checkmark.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // ckecklist
                        Button(action: {
                            // add checklist action
                        }, label: {
                            Image(systemName: "wand.and.stars")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.beigeColor.edgesIgnoringSafeArea(.all))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let converted = Image(uiImage: inputImage)
          image.append(converted)
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas()
    }
}
