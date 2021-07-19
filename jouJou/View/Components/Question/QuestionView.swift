//
//  QuestionView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 19/07/21.
//

import SwiftUI

struct QuestionView: View {
    @Binding var titulo: String
    @State  var isShowingQuestion: Bool = true
    @State  var holdingText: String = "Eu diria que..."
    
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
                        .frame(width: 660, height: 170)
                        .font(Font.custom("Raleway-Regular", size: 20))
                        .foregroundColor(Color.gray)

            }.frame(width: 660)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(titulo: .constant("Como tais se sentindo, mana?"))
    }
}
