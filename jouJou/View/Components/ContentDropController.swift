//
//  ContentDropController.swift
//  jouJou
//
//  Created by Dara Caroline on 19/07/21.
//

import Foundation
import SwiftUI

public struct ContentDropController:DropDelegate{
    @Binding  var images: [Image]
    @Binding  var text: Int
    @Binding var conteudo:String


    
    public func performDrop(info: DropInfo) -> Bool {
      guard info.hasItemsConforming(to: [.image]) else {
        return false
      }
      return receiveDrop(
        itemProviders: info.itemProviders(for: [.image]))
    }
    
   public  func validateDrop(info: DropInfo) -> Bool {
        return info.hasItemsConforming(to: [.image])
    }
    
    public func loadImage(imagem:UIImage?) {
        guard let inputImage = imagem else { return }
        let converted = Image(uiImage: inputImage)
          images.append(converted)
    }
    
    public func loadText(texto:String){
        conteudo = texto
        text = text + 1
        
    }
    
    private func dropText(
      from provider: NSItemProvider
    ) {
      _ = provider.loadObject(ofClass: String.self) { text, _ in
        let newText = text
        DispatchQueue.main.async {
            loadText(texto: newText!)
        }
      }
    }
    
    public func dropImage(from provider: NSItemProvider){
        _ = provider.loadObject(ofClass: UIImage.self){ image, _ in
            if let imagem = image as? UIImage{
                DispatchQueue.main.async {
                    loadImage(imagem: imagem)
                }
            }
            
        }
    }
    
    @discardableResult
    func receiveDrop(
      itemProviders: [NSItemProvider]
    ) -> Bool {
      var result = false
      for provider in itemProviders {
        if provider.canLoadObject(ofClass: String.self) {
          result = true
          dropText(from: provider)
        } else if provider.canLoadObject(ofClass: UIImage.self) {
          result = true
          dropImage(from: provider)
        }
      }
      return result
    }
    
}
