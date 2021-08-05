//
//  CanvasEditor.swift
//  jouJou
//
//  Created by Dara Caroline on 28/07/21.
//

import Foundation
import SwiftUI
import PencilKit

struct CanvasEditor: View {
  //  @Binding var selectedDate:Date?
    //var selectedDate:Date

    let dateFormatter = DateFormatter()
    var data:String = ""
    var anotacao:Anotacao
    //text
   
    //background
    @State var isBackgroundPopoverPresented = false
    @State var backgroundType = "Papel-Liso"
    
  
    @State var shouldScroll: Bool = true
    @State var dismiss = true
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 45) {
                                     
                    Image(uiImage: UIImage(data: (anotacao.imagem)! as Data) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                 
                }
                .background(BackgroundCanvas(type: backgroundType).edgesIgnoringSafeArea(.all))
                
                
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .introspectScrollView { scrollView in
                //scrollView.refreshControl = UIRefreshControl()
                scrollView.isScrollEnabled = shouldScroll
            }
           
            .background(BackgroundCanvas2(type: backgroundType).edgesIgnoringSafeArea(.all))
       
            .navigationTitle("")
            .navigationViewStyle(StackNavigationViewStyle())
           
            
        }
        .onAppear{
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            dateFormatter.locale = Locale.current
            
        }
        
    }
    
   
    
}


