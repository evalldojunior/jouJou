//
//  Humor.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 19/07/21.
//

import Foundation
import SwiftUI

struct Humor: View {
    
    @State var isSelected = -1
    @State var selectedMood = ""
    @State private var isPresented = false
    
    var moods: [String] = ["Animade!", "Tranquile", "OK", "Ansiose", "Estressade", "Para Baixo"]
    var ImageMoods: [String] = ["animade", "tranquile", "ok", "ansiose", "estressade", "parabaixo"]
    var colorMoods: [Color] = [Color.greenColor, Color.greenColor, Color.greenColor, Color.greenColor, Color.greenColor, Color.greenColor] // mudar para as cores corretas depois
    
    var collums = [
        // define number of caullum here
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    func selected(index: Int)  -> Bool {
        if isSelected == index {
            return true
        } else {
            return false
        }
    }
    
    func disable()  -> Bool {
        if selectedMood != "" {
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
    
    func ipad10inch() -> Bool{
        if UIScreen.main.bounds.height < 1050 {
            return true
        } else {
            return false
        }
    }
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(Color.beigeColor.opacity(0.0001))
        UINavigationBar.appearance().barTintColor = UIColor(.beigeColor)
    }
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack{
                    VStack {
                        Text("Como você está se sentindo?")
                            .font(.custom("Raleway-Semibold", size: 24))
                            .foregroundColor(Color.blackColor)
                            .multilineTextAlignment(.center)
                        
                        Spacer().frame(height: 60)
                        
                        VStack{
                            LazyVGrid(columns: collums, alignment: .center, spacing: ipad10inch() ? 30 : 50) {
                                ForEach(0..<moods.count, id: \.self) { index in
                                    VStack {
                                        Button(action: {
                                            selectedMood = moods[index]
                                            withAnimation(){
                                                isSelected = index
                                            }
                                        }, label: {
                                            VStack(alignment:.center, spacing: 0){
                                                Image("\(ImageMoods[index])")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .padding(3)
                                                Text("\(moods[index])")
                                                    .font(.custom("Raleway-Bold", size: 20))
                                                    .foregroundColor(.beigeColor)
                                                    .multilineTextAlignment(.center)
                                                    .padding(7)
                                            }.padding(5)
                                        }).frame(width: ipad13inch() ? 220 : 170 , height: ipad13inch() ? 240 : 190)
                                        .clipped()
                                        .background(selected(index: index) ? Color.orangeColor : colorMoods[index])
                                        .cornerRadius(10)
                                        //.shadow(radius: 6)
                                        .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2), radius: 5, x: 0.0, y: 0.0)
                                        
                                    }
                                }
                            }
                        }
                        Spacer().frame(height: ipad10inch() ? 40 : 0)
                    }
                    
                    VStack {
                        Spacer()
                        Text("Bem-vinde de volta!")
                            .font(.custom("LibreBaskerville-Regular", size: 40))
                            .frame(width: 540)
                            .foregroundColor(Color.blackColor)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Rectangle()
                            .frame(height: 480)
                            .foregroundColor(.clear)
                        
                        Spacer()
                        
                        /// next page button
                        VStack(spacing: 5) {
                            HStack {
                                Spacer()
                                NavigationLink(destination: Canvas()) {
                                    Button(action: {
                                        //action escrever sobre isso
                                    }, label: {
                                        HStack {
                                            Spacer()
                                            Text("Escrever sobre isso")
                                                .font(.custom("Raleway-SemiBold", size: 24))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.beigeColor)
                                                .multilineTextAlignment(.center)
                                                .padding(7)
                                            Spacer()
                                        }
                                        
                                    }).frame(width:440 , height: 51)
                                    .clipped()
                                    .background(Color.blueColor.opacity(disable() ? 0.53 : 1))
                                    .cornerRadius(50)
                                    .shadow(radius: disable() ? 0 : 6)
                                    .disabled(!disable())
                                }
                                Spacer()
                            }
                            
                            NavigationLink(destination: Home()) {
                                Text("Agora não")
                                    .font(.custom("Raleway-SemiBold", size: 24))
                                    .foregroundColor(.blueColor)
                                    .multilineTextAlignment(.center)
                                    .padding(7)
                                //                            Button(action: {
                                //                                //action agora nao
                                //                            }, label: {
                                //                                Text("Agora não")
                                //                                    .font(.custom("Raleway-SemiBold", size: 24))
                                //                                    .foregroundColor(.blueColor)
                                //                                    .multilineTextAlignment(.center)
                                //                                    .padding(7)
                                //                            })
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
        .navigationTitle("")
        .navigationBarHidden(true)
        .accentColor(Color.blueColor)
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

struct Humor_Previews: PreviewProvider {
    static var previews: some View {
        Humor()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)"))
        
        Humor()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
        
        Humor()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        
        Humor()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
}
