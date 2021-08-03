//
//  TextView.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 13/07/21.
//

import Foundation
import SwiftUI
enum SimultaneousState {
    case inactive
    case rotating(angle: Angle)
    case zooming(scale: CGFloat)
    case both(angle: Angle, scale: CGFloat)
    
    var rotationAngle: Angle {
        switch self {
        case .rotating(let angle):
            return angle
        case .both(let angle, _):
            return angle
        default:
            return Angle.zero
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .zooming(let scale):
            return scale
        case .both(_, let scale):
            return scale
        default:
            return CGFloat(1.0)
        }
    }
}

struct TextView: View {
    
    @GestureState var simultaneousState = SimultaneousState.inactive
    @State var viewRotationState = Angle.zero
    @State var viewMagnificationState = CGFloat(1.0)
    @State var isShowingTextView = true
    @Binding var shouldScroll: Bool

    
    var rotationAngle: Angle {
        return viewRotationState + simultaneousState.rotationAngle
    }
    
    var magnificationScale: CGFloat {
        return viewMagnificationState * simultaneousState.scale
    }
    
    public var conteudo : String
    @State var text: String = "Clique aqui para adicionar o texto"
    @State private var height: CGFloat = 14
    @State private var width: CGFloat = .zero
    
    @State private var rectPosition = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    @State private var degree = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    @State var isEditing = false
//    @Binding var dismiss: Bool
    
    
    init(shouldScroll: Binding<Bool>, conteudo:String){
        //Remove the default background of the TextEditor/UITextView
        UITextView.appearance().isScrollEnabled = false
        UITextView.appearance().backgroundColor = .clear
        self.conteudo = conteudo
        self._shouldScroll = shouldScroll
//        self._dismiss = dismiss
    }
    
    var body: some View {
        if isShowingTextView {
            let magnificationGesture = MagnificationGesture()
            
            let rotationGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 5))
            
            let simultaneous = SimultaneousGesture(magnificationGesture, rotationGesture)
                .updating($simultaneousState) { value, state, transation in
                    if isEditing {
                        if value.first != nil && value.second != nil {
                            state = .both(angle: value.second!, scale: value.first!)
                        } else if value.first != nil {
                            state = .zooming(scale: value.first!)
                        } else if value.second != nil {
                            state = .rotating(angle: value.second!)
                        } else {
                            state = .inactive
                        }
                        self.shouldScroll = false
                    }
                }.onEnded { value in
                    if isEditing {
                        self.viewMagnificationState *= value.first ?? 1
                        self.viewRotationState += value.second ?? Angle.zero
                        self.shouldScroll = true
                    }
                }

            VStack(alignment: .center) {             
                ZStack (alignment: .top){
                    TextEditor(text: $text)
                        .frame(width: width + 17, height: height + 17)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(Font.custom("Raleway-Regular", size: 24))
                        .foregroundColor(Color.blackColor)
                        .multilineTextAlignment(.center)
                        .introspectTextView { textView in
                            textView.isScrollEnabled = false
                        }
                        .onTapGesture {
                            withAnimation{
                                isEditing = true
                            }
                            if self.text == "Clique aqui para adicionar o texto" {
                                self.text = " "
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blueColor, lineWidth: isEditing ? 2.0 : 0)
                                .frame(width: width + 70, height: height + 15)
                        )
                        
                    
                    
                    Text(text)
                        .onDrag {
                            NSItemProvider(object: text as NSString)
                        }
                        .background(GeometryReader {
                            Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                            Color.clear.preference(key: ViewWidthKey.self, value: $0.frame(in: .local).size.width)
                        })
                        .frame(maxWidth: 500)
                        .font(Font.custom("Raleway-Regular", size: 24))
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.center)
                        .opacity(0)
                    
                    HStack{
                        Spacer()
                        if isEditing{
                            Button(action: {
                                withAnimation{
                                    isShowingTextView = false
                                }
                            }, label: {
                                ZStack {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.beigeColor)
                                        .font(.system(size: 14))
                                }
                                .frame(width:24 , height: 24)
                                .clipped()
                                .background(Color.blueColor)
                                .cornerRadius(50)
                                .shadow(radius: 6)
                            })
                            .padding(5)
                        }
                    }.frame(width: width + 70)
                    
                }
                .rotationEffect(rotationAngle)
                .scaleEffect(magnificationScale)
                .position(rectPosition)
                .gesture(
                    DragGesture(minimumDistance: shouldScroll ? 3 : 1000)
                        .onChanged { value in
                            if isEditing {
                                self.rectPosition = value.location
                                self.shouldScroll = false
                            }
                        }
                        .onEnded { _ in
                            if isEditing {
                                self.shouldScroll = true
                            }
                        }
                )
                .gesture(simultaneous)
                .onPreferenceChange(ViewHeightKey.self) { height = $0 }
                .onPreferenceChange(ViewWidthKey.self) { width = $0 }
//                .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .background(Color.red.opacity(0.5))
                .onTapGesture {
                    isEditing.toggle()
                    //self.endTextEditing()

                }
                
                
            }
//            .onChange(of: dismiss, perform: { value in
//                self.isEditing = false
//            })
            //.frame(width: width+100, height: height+100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            //        .background(Color.black.onTapGesture {
            //            self.endTextEditing()
            //        }) // coloquei aqui porque o de baixo nao tava pegando kkkkk
            //.background(Color.red) //por algum motivo, resolvi o bug colocando background
//            .onTapGesture {
//                isEditing.toggle()
//                self.endTextEditing()
//
//            }
            .onAppear(perform: {
                if (self.conteudo != ""){
                    text = self.conteudo
                }
            })
            

        }
    }
}

//struct TextView_Previews: PreviewProvider {
//    static var previews: some View {
//       // TextView()
//    }
//}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
        print("Reporting height: \(value)")
    }
}

struct ViewWidthKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
        print("Reporting width: \(value)")
    }
}
