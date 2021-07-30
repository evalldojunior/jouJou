//
//  Home.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 19/07/21.
//

import Foundation
import SwiftUI

struct Home: View {
    
    // resumo do mes
    @State var title: String = "Julho está sendo um mês animado!"
    @State var text: String = "Algum textinho fofo pra pessoa <3 pipipopopopipijncsjnsjnlalalala parabens continue assim, estamos felizes por vc!!"
    @State var image: String = "exemplo1"
    
    // fotos do mes
    var images: [String] = ["exemplo2", "exemplo3", "exemplo2", "exemplo3", "exemplo2"]
    var subtitles: [String] = ["gay rights", "a lua - Pabllo Vittar", "mais gays", "a lua me traiu", "chega de gays"]
    var days: [String] = ["13/07", "12/07", "11/07", "10/07", "09/07"]
    
    // escritas mais recentes
    var text2 = "Hoje eu tananan tananan blablabla foi muito massa pq tipo foi legal demais! e fora bolsonaro lixo ..."
    var subtitlesCards: [String] = ["13 de julho de 2021", "12 de julho de 2021", "11 de julho de 2021", "10 de julho de 2021", "09 de julho de 2021"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack {
                        ///calendario
                        Calendar()
                            .frame(width: 640, height: 570)
                            .padding(56)
                            

                        /// resumo do mes
                        HStack {
                            VStack(alignment: .leading, spacing: 7){
                                Text(title)
                                    .font(.custom("Raleway-Bold", size: 30))
                                    .foregroundColor(.blackColor)
                                    .multilineTextAlignment(.leading)
                                Text(text)
                                    .font(.custom("Raleway-Regular", size: 24))
                                    .foregroundColor(.blackColor)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                                .frame(width: 175, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.horizontal, 56)
                        
                        Spacer().frame(height: 60)
                        
                        /// fotos do mes
                        VStack(alignment: .leading){
                            Text("Algumas fotos de julho")
                                .font(.custom("Raleway-Bold", size: 24))
                                .foregroundColor(.blackColor)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 56)
                                //.padding(.vertical)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 20) {
                                    ForEach(0..<images.count, id: \.self) { index in
                                        //gamby
                                        if index == 0 {
                                            Spacer().frame(width: 36)
                                        }
                                        
                                        VStack() {
                                            Image(images[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 186, height: 192, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .cornerRadius(10)
                                            
                                            Text(subtitles[index])
                                                .font(.custom("Raleway-SemiBold", size: 14))
                                                .foregroundColor(.blackColor)
                                                .multilineTextAlignment(.center)
                                            
                                            Text(days[index])
                                                .font(.custom("Raleway-Regular", size: 14))
                                                .foregroundColor(.blackColor)
                                                .multilineTextAlignment(.center)
                                        }.frame(width: 190, height: 235, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }.frame(height: 250)
                        }
                        
                        Spacer().frame(height: 60)
                        
                        /// musicas do mes
                        VStack(alignment: .leading){
                            Text("Algumas músicas marcantes de julho")
                                .font(.custom("Raleway-Bold", size: 24))
                                .foregroundColor(.blackColor)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 56)
                                //.padding(.vertical)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 20) {
                                    ForEach(0..<images.count, id: \.self) { index in
                                        //gamby
                                        if index == 0 {
                                            Spacer().frame(width: 36)
                                        }
                                        HStack(alignment: .bottom,spacing: 0){
                                            Image(images[index])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 54, height: 54, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .cornerRadius(5)
                                                .padding(10)
                                            
                                            VStack(alignment: .leading, spacing: 3){
                                                Text("Solar Power")
                                                    .font(.custom("Raleway-SemiBold", size: 14))
                                                    .foregroundColor(.blackColor)
                                                    .multilineTextAlignment(.leading)
                                                
                                                Text("Lorde")
                                                    .font(.custom("Raleway-Regular", size: 14))
                                                    .foregroundColor(.blackColor)
                                                    .multilineTextAlignment(.leading)
                                            }.padding(.bottom, 10)
                                        }.frame(width: 211, height: 76, alignment: .leading)
                                        .background(Color.whiteColor)
                                        .cornerRadius(10)
                                        //.shadow(radius: 6)
                                        .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2), radius: 5, x: 0.0, y: 0.0)
                                        
                                    }
                                }
                            }.frame(height: 100)
                        }
                        
                        
                        Spacer().frame(height: 60)
                        
                        /// escritas mais recentes
                        VStack(alignment: .leading){
                            Text("Suas escritas mais recentes")
                                .font(.custom("Raleway-Bold", size: 24))
                                .foregroundColor(.blackColor)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 56)
                                //.padding(.vertical)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 20) {
                                    ForEach(0..<images.count, id: \.self) { index in
                                        //gamby
                                        if index == 0 {
                                            Spacer().frame(width: 36)
                                        }
                                        
                                        VStack(alignment: .center, spacing: 10) {
                                            VStack{
                                                HStack{
                                                    Text(text2)
                                                        .font(.custom("Raleway-Regular", size: 20))
                                                        .foregroundColor(.blackColor)
                                                        .multilineTextAlignment(.leading)
                                                    Spacer()
                                                    Image(image)
                                                        .resizable()
                                                        .scaledToFit()
                                                        //.padding(10)
                                                        .frame(width: 100, height: 112, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                }
                                            }
                                            .padding()
                                            .frame(width: 300, height: 181)
                                            .background(Color.beigeColor)
                                            .cornerRadius(10)
                                            HStack{
                                                Text(subtitlesCards[index])
                                                    .font(.custom("Raleway-Bold", size: 20))
                                                    .foregroundColor(.beigeColor)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.horizontal)
                                                Spacer()
                                            }
                                        }.frame(width: 315, height: 235, alignment: .leading)
                                        .background(Color.greenColor)
                                        .cornerRadius(10)
                                        //.shadow(radius: 6)
                                        .shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2), radius: 5, x: 0.0, y: 0.0)
                                    }
                                }
                            }.frame(height: 260)
                        }
                        
                        
                        
                    }
                    //.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }//.padding(.horizontal, 90)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                
                
                // botao escrever
                VStack(alignment: .center){
                    NavigationLink(destination: Canvas()) {
                        ZStack {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.beigeColor)
                                .padding(20)
                                .padding(.leading,4)
                        }
                        .frame(width:80 , height: 80)
                        .clipped()
                        .background(Color.blueColor)
                        .cornerRadius(50)
                        .shadow(radius: 6)
//                        Button(action: {
//                            //action escrever
//                        }, label: {
//                            Image(systemName: "square.and.pencil")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundColor(.beigeColor)
//                                .padding(20)
//                                .padding(.leading,4)
//                            
//                        }).frame(width:80 , height: 80)
//                        .clipped()
//                        .background(Color.blueColor)
//                        .cornerRadius(50)
//                        .shadow(radius: 6)
                    }
                }
                .padding([.horizontal, .bottom], 30)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottomTrailing)
            }
            //.padding(.horizontal, 90)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .background(Color.beigeColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
            
        }
        .navigationTitle("Home")
        .navigationBarHidden(true)
    }
}


