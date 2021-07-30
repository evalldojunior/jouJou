//
//  ImageTestView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 08/07/21.
//
import Foundation
import SwiftUI

struct ImageTestView: View {
    @State private var showingImagePicker = false
    @State private var showingImageOptions = false
    @State private var inputImage: UIImage?
    @State  var image: [Image] = []
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var numberOfImages = 0
    
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack{
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
                Spacer()
            }
            ForEach((0..<image.count), id: \.self) { i in
                ImageView(image: image[i], shouldScroll: .constant(true))
            }
        }
        
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        var converted = Image(uiImage: inputImage)
          image.append(converted)
    }
}

struct ImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTestView()
    }
}
