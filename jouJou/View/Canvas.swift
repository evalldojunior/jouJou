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
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
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
    var dateFormatter = DateFormatter()
    var today = Date()
    @State var shouldScroll: Bool = true
    @State var dismiss = true
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Anotacao.entity(), sortDescriptors: []) var anotacoes: FetchedResults<Anotacao>
    
    @State var dismissText = true
    @State var shouldScrollPencil: Bool = true
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {

                VStack() {
                    
                    // canvas
                    ZStack(alignment: .top){
                        
                        //desenhos
                        DrawingView(showingToolPicker: $pencilTapped, drawingView: $drawingView)
                        
                        // parte de cima
                        VStack(spacing: 45) {
                            Spacer().frame(height: 5).background(Color.red)
                            // data
                    Text(dateFormatter.string(from: today))
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
                            
                            Spacer().frame(height: 600)
                        }
                        
                        //imagens
                        ForEach((0..<image.count), id: \.self) { i in
                            ImageView(image: image[i])
                        }
                        
                        //stickers
                        ForEach((0..<stickersTapped.count), id: \.self) { k in
                            ImageView(image: Image(stickersTapped[k]))
                        }
                        
                        //textos
                        ForEach((0..<text), id: \.self) { _ in

                            TextView(shouldScroll: $shouldScroll, dismiss: $dismissText, conteudo: conteudo)
                        }
                    }
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                    //.background(Color.black.opacity(0.2))
                }
                .introspectScrollView { scrollView in
                    scrollView.isScrollEnabled = shouldScrollPencil
                }
                .background(BackgroundCanvas(type: backgroundType).edgesIgnoringSafeArea(.all))
                
                
                
//                .introspectScrollView { scrollView in
//                    scrollView.isScrollEnabled = teste
//                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onDrop(of: [.image, .text], isTargeted: nil) { providers in
                let dropController = ContentDropController(
                    images: $image,text: $text, conteudo: $conteudo)
                return dropController.receiveDrop(
                    itemProviders: providers)
            }
            .background(shouldScrollPencil ? BackgroundCanvas2(type: backgroundType).edgesIgnoringSafeArea(.all) : BackgroundCanvas2(type: backgroundType).edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage, sourceType: sourceType)
            }
            .toolbar{
                ToolbarItemGroup(placement: .principal) {
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
                        .popover(isPresented: $showingImageOptions) {
                            VStack (alignment: .center) {
                                Text("Adicionar imagem")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                                    .padding([.top, .horizontal])
                                    .padding(.bottom, 1)
                                
                                Text("Selecione uma opção abaixo")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom)
                                    
                                    
                                Divider()
                                //camera
                                Button(action: {
                                    sourceType = .camera
                                    showingImagePicker = true
                                    withAnimation{
                                        self.showingImageOptions.toggle()
                                    }
                                }, label: {
                                    Text("Câmera")
                                        .fontWeight(.medium)
                                        .frame(width: 250)
                                        .padding()
                                })
                                Divider()
                                //galeria
                                Button(action: {
                                    sourceType = .photoLibrary
                                    showingImagePicker = true
                                    withAnimation{
                                        self.showingImageOptions.toggle()
                                    }
                                }, label: {
                                    Text("Galeria")
                                        .fontWeight(.medium)
                                        .frame(width: 250)
                                        .padding()
                                })
                            }
                            .frame(width: 280, height: 230)
                            
                        }
                        
//                        // MARK: - Tool: song
//                        Button(action: {
//                            
//                        }, label: {
//                            Image(systemName: "music.note")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 28, height: 30, alignment: .center)
//                                .foregroundColor(Color.blueColor)
//                        })
                        
                        // MARK: - Tool: draw
                        
                        Button(action: {
                            shouldScrollPencil.toggle()
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
                self.dismiss.toggle()
                self.dismissText = true
            }
            .onAppear(perform: {
                self.pencilTapped = false
                dateFormatter.dateStyle = .full
                dateFormatter.timeStyle = .none
                dateFormatter.locale = Locale.current
                
            })
            .onDisappear(perform: {
                self.pencilTapped = false
                print("desapareceu")
                

            })
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(trailing:
                                    Button(action: {
                                        let image = body.asImage(size:  CGSize(width: geometry.size.width, height: geometry.size.height))
                                        let data = image.jpegData(compressionQuality: 1.0)
                                        let anotacao = Anotacao(context: managedObjectContext)
                                        anotacao.imagem = data
                                        anotacao.dia = Date()
                                        

                                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

                                    }) {
                                        Text("Finalizar")
                                            
                                    }
            )
            
        }
        .preferredColorScheme(.light)
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let converted = Image(uiImage: inputImage)
        image.append(converted)
    }
}
extension UIView{
    func image()->UIImage{
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension View {
    func asImage(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.image()
        return image
    }
}

struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas()
    }
}
