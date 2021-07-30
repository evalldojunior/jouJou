//
//  Introduction.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 14/07/21.
//

import Foundation
import SwiftUI

struct Introduction: View {
    @State var name = ""
    //@State var selectedPronoun = "elu / delu"
    @State var isExpanded = false
    @State var selectedPronoun = "Selecione seu pronome"
    //@State var
    var pronouns = ["elu / delu", "ela / dela", "ele / dele"]
    
    func disable()  -> Bool {
        if name != "" && selectedPronoun != "Selecione seu pronome"{
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack{
                    VStack(alignment: .leading, spacing: 15) {
                        Text("teChame")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.blackColor)
                            .multilineTextAlignment(.leading)
                        TextField("| ", text: $name)
                            .font(.custom("Raleway-Regular", size: 20))
                            .foregroundColor(Color.blackColor)
                            .padding()
                            .background(Color.lightSalmonColor)
                            .cornerRadius(10)
                        
                        Spacer()
                            .frame(height:110)
                        
                        Text("pronomes")
                            .font(.custom("Raleway-Regular", size: 24))
                            .foregroundColor(Color.blackColor)
                            .multilineTextAlignment(.leading)
                        DisclosureGroup(isExpanded: $isExpanded) {
                            GeometryReader() { geometry in
                                VStack(spacing:0) {
                                    Spacer().frame(height:10)
                                    ForEach(pronouns, id: \.self) { pronoun in
                                        Text(pronoun)
                                            .font(.custom("Raleway-Regular", size: 20))
                                            .foregroundColor(Color.blackColor)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .background(Color.lightSalmonColor)
                                            .onTapGesture {
                                                self.selectedPronoun = pronoun
                                                withAnimation() {
                                                    self.isExpanded.toggle()
                                                }
                                            }
                                        
                                        Divider()
                                            .background(Color.darkSalmonColor)
                                        
                                    }
                                }.frame(width: geometry.size.width)
                                
                            }.frame(height:170)
                            
                        } label: {
                            HStack {
                                Text(selectedPronoun)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.endTextEditing()
                                withAnimation {
                                    isExpanded.toggle()
                                }
                                UserDefaults.standard.set(self.name, forKey: "Nome")
                                UserDefaults.standard.set(self.selectedPronoun, forKey: "Pronomes")
                            }
                        }
                        .padding()
                        .background(Color.lightSalmonColor)
                        .cornerRadius(10)
                        .font(.custom("Raleway-Regular", size: 20))
                        .foregroundColor(Color.blackColor)
                        .accentColor(Color.blueColor)
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        /// logo
                        Spacer()//.frame(height: 150)
                        VStack {
                            Text("Olá! Bem-vinde ao")
                                .font(.custom("LibreBaskerville-Regular", size: 30))
                            HStack(alignment: .center, spacing: -15){
                                Spacer()
                                Text(" jou")
                                    .font(.custom("LibreBaskerville-Regular", size: 64))
                                    .foregroundColor(Color.blueColor)
                                Text(" jou")
                                    .font(.custom("LibreBaskerville-Regular", size: 64))
                                    .foregroundColor(Color.darkSalmonColor)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        
                        Rectangle()
                            .frame(height: 435)
                            .foregroundColor(.clear)
                        
                        Spacer()
                        
                        /// next page button
                        VStack {
                            HStack {
                                Spacer()
                                NavigationLink(destination: SelectStyle(name: UserDefaults.standard.string(forKey: "Nome") ?? name)) {
                                    Button(action: {
                                        //action
                                    }, label: {
                                        HStack {
                                            Spacer()
                                            Text("Avançar")
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
                .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
                .background(Color.beigeColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
                .onTapGesture {
                    self.endTextEditing()
                    if isExpanded {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                }
            }
            
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        Introduction()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)"))
        
        Introduction()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
        
        Introduction()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
        
        Introduction()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
}


//struct Introduction: View {
//    @State var name = ""
//    //@State var selectedPronoun = "elu / delu"
//    @State var isExpanded = false
//    @State var selectedPronoun = "Selecione seu pronome"
//    //@State var
//    var pronouns = ["elu / delu", "ela / dela", "ele / dele"]
//
//    func disable()  -> Bool {
//        if name != "" && selectedPronoun != "Selecione seu pronome"{
//            return false
//        } else {
//            return true
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            /// logo
//            Spacer()//.frame(height: 150)
//            VStack {
//                Text("Olá! Bem-vinde ao")
//                    .font(.custom("LibreBaskerville-Regular", size: 30))
//                HStack(alignment: .center, spacing: -15){
//                    Spacer()
//                    Text(" jou")
//                        .font(.custom("LibreBaskerville-Regular", size: 64))
//                        .foregroundColor(Color.blueColor)
//                    Text(" jou")
//                        .font(.custom("LibreBaskerville-Regular", size: 64))
//                        .foregroundColor(Color.darkSalmonColor)
//                    Spacer()
//                }
//            }
//
//            Spacer()
//
//            /// inputs
//            Text("teChame")
//                .font(.custom("Raleway-Regular", size: 24))
//                .foregroundColor(Color.blackColor)
//                .multilineTextAlignment(.leading)
//            TextField("| ", text: $name)
//                .font(.custom("Raleway-Regular", size: 20))
//                .foregroundColor(Color.blackColor)
//                .padding()
//                .background(Color.lightSalmonColor)
//                .cornerRadius(10)
//
//            Spacer()
//                .frame(height:130)
//
//            Text("pronomes")
//                .font(.custom("Raleway-Regular", size: 24))
//                .foregroundColor(Color.blackColor)
//                .multilineTextAlignment(.leading)
//            DisclosureGroup(isExpanded: $isExpanded) {
//                GeometryReader() { geometry in
//                    VStack(spacing:0) {
//                        Spacer().frame(height:10)
//                        ForEach(pronouns, id: \.self) { pronoun in
//                            Text(pronoun)
//                                .font(.custom("Raleway-Regular", size: 20))
//                                .foregroundColor(Color.blackColor)
//                                .padding()
//                                .frame(maxWidth: .infinity, alignment: .center)
//                                .background(Color.lightSalmonColor)
//                                .onTapGesture {
//                                    self.selectedPronoun = pronoun
//                                    withAnimation() {
//                                        self.isExpanded.toggle()
//                                    }
//                                }
//
//                            Divider()
//                                .background(Color.darkSalmonColor)
//
//                        }
//                    }.frame(width: geometry.size.width)
//
//                }.frame(height:170)
//
//            } label: {
//                HStack {
//                    Text(selectedPronoun)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    withAnimation {
//                        isExpanded.toggle()
//                    }
//                }
//            }
//            .padding()
//            .background(Color.lightSalmonColor)
//            .cornerRadius(10)
//            .font(.custom("Raleway-Regular", size: 20))
//            .foregroundColor(Color.blackColor)
//            .accentColor(Color.blueColor)
//
//            Spacer()
//
//            /// next page button
//            VStack {
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        //action
//                    }, label: {
//                        HStack {
//                            Spacer()
//                            Text("Avançar")
//                                .font(.custom("Raleway-SemiBold", size: 24))
//                                .fontWeight(.semibold)
//                                .foregroundColor(.beigeColor)
//                                .multilineTextAlignment(.center)
//                                .padding(7)
//                            Spacer()
//                        }
//
//                    }).frame(width:230 , height: 51)
//                    .clipped()
//                    .background(Color.blueColor.opacity(disable() ? 0.53 : 1))
//                    .cornerRadius(50)
//                    .shadow(radius: disable() ? 0 : 6)
//                    .disabled(disable())
//                    Spacer()
//                }
//
//                Spacer().frame(height: 90)
//            }
//        }
//        .padding(.horizontal, 90)
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .leading)
//        .background(Color.beigeColor.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
//        .onTapGesture {
//            self.endTextEditing()
//            if isExpanded {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }
//        }
//    }
//}
