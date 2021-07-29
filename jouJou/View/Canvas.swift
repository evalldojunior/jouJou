//
//  Canvas.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 13/07/21.
//

import Foundation
import SwiftUI
import PencilKit
import Introspect

struct Canvas: View {
    
    //text
    @State var text = 0
    //image
    @State private var showingImagePicker = false
    @State private var showingImageOptions = false
    @State private var inputImage: UIImage?
    @State  var image: [Image] = []
    @State var sourceType: UIImagePickerController.SourceType = .camera
    //drawing
    @State private var drawingView = PKCanvasView()
    @State var pencilTapped = false
    //sticker
    @State var isStickerPopoverPresented = false
    @State var StickersGrid = StickersGridView()
    let stickers = ["Passaro", "Coracao", "Sol", "Folha", "Rosa", "Jacinto", "Tulipa", "Sakura", "Lavanda"]
    @State var stickersTapped: [String] = []
    @State var conteudo: String = ""
    
    
    //question
    @State var questionTitle = ""
    @State var isQuestionPopoverPresented = false
    @State var questions = ["tais bem?", "o que te deixa irritado?", "o que te faz feliz?", "quais as novidades?", "o que tem te deixado ansioso?"]
    @State var questionsTapped: [String] = []
    
    //background
    @State var isBackgroundPopoverPresented = false
    @State var backgroundType = "Papel-Liso"
    
    //To-Do list
    @State var ToDos = 0
    
    // data
    var day = "Sexta-feira, 6 de julho de 2021"
    @State var shouldScroll: Bool = true
    @State var dismiss = true
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 45) {
                    
                    // data
                    Text(day)
                        .font(.custom("LibreBaskerville-Regular", size: 30))
                        .foregroundColor(Color.blackColor)
                        .multilineTextAlignment(.center)
                    
                    //To-do List
                    VStack(spacing: 28) {
                        ForEach((0..<ToDos), id: \.self) { _ in
                            withAnimation{
                                ToDoView(dismiss: $dismiss)
                            }
                        }
                        
                    }
                    
                    //perguntas
                    VStack(spacing: 28) {
                        ForEach((0..<questionsTapped.count), id: \.self) { question in
                            withAnimation{
                                QuestionView(titulo: $questionsTapped[question], dismiss: $dismiss)
                            }
                        }
                    }
                    
                    // canvas
                    ZStack {
                        
                        //desenhos
                        DrawingView(showingToolPicker: $pencilTapped, drawingView: $drawingView)
                        
                        //imagens
                        ForEach((0..<image.count), id: \.self) { i in
                            ImageView(image: image[i], shouldScroll: $shouldScroll)
                        }
                        
                        //stickers
                        ForEach((0..<stickersTapped.count), id: \.self) { k in
                            ImageView(image: Image(stickersTapped[k]), shouldScroll: $shouldScroll)
                        }
                        
                        //textos
                        ForEach((0..<text), id: \.self) { _ in
                            TextView(shouldScroll: $shouldScroll, conteudo: conteudo)
                        }
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    //.background(Color.black)
                }
                .background(BackgroundCanvas(type: backgroundType).edgesIgnoringSafeArea(.all))
                
                
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .introspectScrollView { scrollView in
                //scrollView.refreshControl = UIRefreshControl()
                scrollView.isScrollEnabled = shouldScroll
            }
            .onDrop(of: [.image, .text], isTargeted: nil) { providers in
                let dropController = ContentDropController(
                    images: $image,text: $text, conteudo: $conteudo)
                return dropController.receiveDrop(
                    itemProviders: providers)
            }
            .background(BackgroundCanvas2(type: backgroundType).edgesIgnoringSafeArea(.all))
            //            .background(
            //                Image(backgroundType)
            //                    .resizable()
            //                    .scaledToFill()
            //                    .edgesIgnoringSafeArea(.all)
            //            )
            .toolbar{
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 29) {
                        
                        // MARK: - Tool: image
                        
                        Button(action: {
                            self.showingImageOptions = true
                        }) {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 37, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        }
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$inputImage, sourceType: sourceType)
                        }
                        .actionSheet(isPresented: $showingImageOptions, content: {
                            ActionSheet(title: Text("Adicionar Imagem"), message: Text("Selecione uma opção abaixo"), buttons: [
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
                        
                        
                        // MARK: - Tool: song
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "music.note")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // MARK: - Tool: draw
                        
                        Button(action: {
                            pencilTapped.toggle()
                            
                        }, label: {
                            Image(systemName: "pencil.and.outline")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // MARK: - Tool: sticker
                        Button(action: {
                            withAnimation{
                                self.isStickerPopoverPresented = true
                            }
                        }, label: {
                            Image(systemName: "seal")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        }).popover(isPresented: $isStickerPopoverPresented) {
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
                                                isStickerPopoverPresented.toggle()
                                            }) {
                                                Image(post)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geo.size.width/3, height: geo.size.width/3)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(width: 280, height: 280)
                        }
                        
                        // MARK: - Tool: text
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
                        
                        // MARK: - Tool: question
                        Button(action: {
                            withAnimation{
                                self.isQuestionPopoverPresented = true
                            }
                        }, label: {
                            Image(systemName: "note.text.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        }).popover(isPresented: $isQuestionPopoverPresented) {
                            List{
                                ForEach(questions, id: \.self){ question in
                                    Button(action: {
                                        questionsTapped.append(question)
                                        isQuestionPopoverPresented.toggle()
                                    }) {
                                        Text(question)
                                            .font(Font.custom("Raleway-Regular", size: 13))
                                        
                                    }
                                }
                            }
                            .frame(width: 280, height: 280)
                        }
                        
                        // MARK: - Tool: checklist
                        
                        Button(action: {
                            ToDos += 1
                        }, label: {
                            Image(systemName: "checkmark.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        })
                        
                        // MARK: - Tool: background
                        Button(action: {
                            self.isBackgroundPopoverPresented.toggle()
                        }, label: {
                            Image(systemName: "wand.and.stars")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 30, alignment: .center)
                                .foregroundColor(Color.blueColor)
                        }).popover(isPresented: $isBackgroundPopoverPresented) {
                            List{
                                //papel liso
                                Button(action: {
                                    withAnimation{
                                        self.isBackgroundPopoverPresented.toggle()
                                        backgroundType = "Papel-Liso"
                                    }
                                }, label: {
                                    styleRow(type: "Papel Liso", icon: "icone-papel-liso")
                                })
                                //papel pautado
                                Button(action: {
                                    withAnimation{
                                        self.isBackgroundPopoverPresented.toggle()
                                        backgroundType = "Papel-Pautado"
                                    }
                                }, label: {
                                    styleRow(type: "Papel Pautado", icon: "icone-papel-pautado")
                                })
                                //papel quadriculado
                                Button(action: {
                                    withAnimation{
                                        self.isBackgroundPopoverPresented.toggle()
                                        backgroundType = "Papel-Quadriculado"
                                    }
                                }, label: {
                                    styleRow(type: "Papel Quadriculado", icon: "icone-papel-quadriculado")
                                })
                            }//.padding(.top, 20)
                            .frame(width: 280, height: 245)
                        }
                    }
                }
            }
            .onTapGesture {
                self.endTextEditing()
                self.dismiss = true
            }
            .onAppear(perform: {
                self.pencilTapped = false
            })
            .onDisappear(perform: {
                self.pencilTapped = false
            })
            .navigationTitle("")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(trailing:
                                    Button(action: {
                                        
                                    }) {
                                        Text("Finalizar")
                                            
                                    }
            )
            
        }
        
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
