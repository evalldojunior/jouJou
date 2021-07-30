//
//  ToDoView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 26/07/21.
//

import SwiftUI

struct ToDoView: View {
    @State var titulo: String = ""
    @State  var isShowingToDo: Bool = true
    @State  var holdingText: String = "Eu diria que..."
    @State var squareForegroundColor = Color.clear
    @State var taskForegroundColor = Color(#colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6509803922, alpha: 1))
    @State var buttonTapped = false
    @Binding var dismiss: Bool
    
    var body: some View {
        
        if isShowingToDo{
            HStack(spacing: 0){
                Button(action: {
                    if titulo != "" {
                        buttonTapped.toggle()
                        if buttonTapped{
                            squareForegroundColor = Color.blueColor
                            taskForegroundColor = Color.blueColor
                        }else{
                            squareForegroundColor = Color.clear
                            taskForegroundColor = Color(#colorLiteral(red: 0.662745098, green: 0.6588235294, blue: 0.6509803922, alpha: 1))
                        }
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.blueColor, lineWidth: 4)
                })
                .frame(width: 30, height: 30)
                .background(squareForegroundColor)
                .cornerRadius(4)
                .padding(.trailing)
                
                TextField("Levar cachorro para passear", text: $titulo, onEditingChanged: { (changed) in
                    dismiss = false
                }, onCommit: {
                    dismiss = true
                    
                })
                .font(Font.custom("Raleway-Regular", size: 24))
                .foregroundColor(taskForegroundColor)
                Spacer()
                
                if !dismiss {
                    Button(action: {
                        withAnimation{
                            isShowingToDo = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color.blueColor)
                    })
                    
                }
            }.frame(width: 660)
//            .onTapGesture {
//                isShowingButton.toggle()
//            }
        }
    }
}

//struct ToDoView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToDoView(dismiss: true)
//    }
//}
