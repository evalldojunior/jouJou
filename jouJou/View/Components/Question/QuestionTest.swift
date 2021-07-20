//
//  QuestionTest.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 19/07/21.
//

import SwiftUI

struct QuestionTest: View {
        @Binding var titulo: String
        @State  var isShowingQuestion: Bool = true
        @State  var holdingText: String = "Eu diria que..."
        
        init(titulo: Binding<String>){
            self._titulo = titulo
            UITextView.appearance().backgroundColor = .clear
        }
        var body: some View {
            if isShowingQuestion{
                VStack{
                    HStack{
                        Text(titulo)
                            .font(Font.custom("Raleway-Regular", size: 24))
                        Spacer()
                        Button(action: {
                            withAnimation{
                                isShowingQuestion = false
                            }
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Color.blueColor)
                        })
                    }
                    TextEditor(text: $holdingText)
                        .font(Font.custom("Raleway-Regular", size: 20))
                        .foregroundColor(Color.gray)
                        .padding()
                        .background(Color.lightSalmonColor)
                        .cornerRadius(10)
                        .frame(width: 660, height: 170)
                }.frame(width: 660)
            }
        }
}

struct QuestionTest_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTest(titulo: .constant("Como tais se sentindo, mana?"))
    }
}
