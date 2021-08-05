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
    
    @State var text: String = "Clique aqui para adicionar o texto"
    @State private var height2: CGFloat = .zero
    @State private var width2: CGFloat = .zero
    //@State var isShowingButton = false
    @Binding var dismiss: Bool
    
    init(titulo: Binding<String>, dismiss: Binding<Bool>){
        self._titulo = titulo
        self._dismiss = dismiss
        UITextView.appearance().backgroundColor = .clear
        
    }
    var body: some View {
        if isShowingQuestion{
            VStack{
                HStack{
                    Text(titulo)
                        .font(Font.custom("Raleway-Regular", size: 24))
                        .foregroundColor(.blackColor)
                    Spacer()
                    
                    if !dismiss {
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
                }
                ZStack (alignment: .topLeading){
                    TextEditor(text: $holdingText)
                        .frame(width: 630, height: height2 < 120 ? 120 : height2)
                        .introspectTextView { textView in
                            textView.isScrollEnabled = false
                        }
                        .font(Font.custom("Raleway-Regular", size: 20))
                        .foregroundColor(Color(#colorLiteral(red: 0.4225608706, green: 0.4200535417, blue: 0.4244911075, alpha: 1)))
                        .padding(15)
                        .background(Color.lightSalmonColor)
                        .cornerRadius(10)
                        .onTapGesture {
                            dismiss = false
                            if holdingText == "Eu diria que..." {
                                holdingText = ""
                            }
                        }
                    
                    Text(holdingText)
                        .font(Font.custom("Raleway-Regular", size: 20))
                        .padding()
                        .multilineTextAlignment(.leading)
                        .background(GeometryReader { /// quaseeee aff
                            Color.clear.preference(key: ViewHeightKey2.self, value: $0.frame(in: .local).size.height)
                        })
                        .opacity(0)
                        .frame(width: 660, alignment: .leading)
                }.onPreferenceChange(ViewHeightKey2.self) { height2 = $0 }
                
            }.frame(width: 660)
            .onTapGesture {
                dismiss = false
                //isShowingButton = true
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(titulo: .constant("Como tais se sentindo, mana?"), dismiss: .constant(true))
    }
}
struct ViewHeightKey2: PreferenceKey {
    static var defaultValue: CGFloat { 0 } //quase nada amkigo
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
        print("Reporting height: \(value)")
    }
}
