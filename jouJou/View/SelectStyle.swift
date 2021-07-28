//
//  SelectStyle.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 15/07/21.
//

import Foundation
import SwiftUI

struct SelectStyle: View {
    @State var isSelected = -1
    @State var selectedStyle = ""
    
    var name: String!
    var styles: [String] = ["Objetiva", "Livre", "Bullet"]
    var ImageStyles: [String] = ["exemplo", "exemplo", "exemplo"]
    
    init(name: String) {
        self.name = name
    }
    
    var collums = [
        // define number of caullum here
        GridItem(.flexible(), spacing: 60),
        GridItem(.flexible(), spacing: 60),
        GridItem(.flexible(), spacing: 60)
    ]
    
    func selected(index: Int)  -> Bool {
        if isSelected == index {
            return true
        } else {
            return false
        }
    }
    
    func disable()  -> Bool {
        if selectedStyle != "" {
            return false
        } else {
            return true
        }
    }
    
    func ipad13inch() -> Bool{
        if UIScreen.main.bounds.height > 1300 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack {
                    Text("tipoEscrita")
                        .font(.custom("Raleway-Semibold", size: 24))
                        .foregroundColor(Color.blackColor)
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 95)
                    
                    VStack{
                        LazyVGrid(columns: collums, alignment: .center, spacing: 50) {
                            ForEach(0..<styles.count, id: \.self) { index in
                                Button(action: {
                                    selectedStyle = styles[index]
                                    //isSelected = index
                                    withAnimation(){
                                        isSelected = index
                                    }
                                }, label: {
                                    VStack(alignment:.center, spacing: 0){
                                        Image("\(ImageStyles[index])")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(5)
                                        HStack {
                                            Spacer()
                                            Text("\(styles[index])")
                                                .font(.custom("Raleway-Bold", size: 20))
                                                .foregroundColor(.beigeColor)
                                                .multilineTextAlignment(.center)
                                                .padding(7)
                                            Spacer()
                                        }
                                    }.padding(5)
                                    
                                }).frame(width: ipad13inch() ? 250 : 196 , height: ipad13inch() ? 250 : 196)
                                .clipped()
                                .background(selected(index: index) ? Color.orangeColor : Color.greenColor)
                                .cornerRadius(10)
                                .shadow(radius: 6)
                            }
                        }
                        
                    }
                    
                    Spacer().frame(height: 95)
                    
                    Text("instrucaoEscrita")
                        .font(.custom("Raleway-Regular", size: 20))
                        .foregroundColor(Color.blackColor)
                        .multilineTextAlignment(.center)
                    
                }
                
                VStack {
                    Spacer()
                    Text("Nos ajude a te conhecer melhor, \(name)")
                        .font(.custom("LibreBaskerville-Regular", size: 40))
                        .frame(width: 540)
                        .foregroundColor(Color.blackColor)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Rectangle()
                        .frame(height: 435)
                        .foregroundColor(.clear)
                    
                    Spacer()
                    /// next page button
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: Humor()) {
                                Button(action: {
                                    //action
                                }, label: {
                                    HStack {
                                        Spacer()
                                        Text("avancarBtn")
                                            .font(.custom("Raleway-SemiBold", size: 24))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.beigeColor)
                                            .multilineTextAlignment(.center)
                                            .padding(7)
                                        Spacer()
                                    }
                                    
                                }).frame(width:230 , height: 51)
                                .clipped()
                                .background(Color.blueColor.opacity(disable() ? 0.53 : 1))
                                .cornerRadius(50)
                                .shadow(radius: disable() ? 0 : 6)
                                .disabled(!disable())
                                
                            }
                            Spacer()
                        }
                        
                        Spacer().frame(height: 90)
                    }
                }
            }
            .padding(.horizontal, 90)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .background(Color.beigeColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
}

struct SelectStyle_Previews: PreviewProvider {
    static var previews: some View {
        SelectStyle(name: "Gustavo")
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)"))
        
        SelectStyle(name: "Gustavo")
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
        
        SelectStyle(name: "Gustavo")
            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        
        SelectStyle(name: "Gustavo")
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
}
