//
//  TextView.swift
//  jouJou
//
//  Created by Evaldo Garcia de Souza Júnior on 13/07/21.
//

import Foundation
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
    
    
    var rotationAngle: Angle {
        return viewRotationState + simultaneousState.rotationAngle
    }
    
    var magnificationScale: CGFloat {
        return viewMagnificationState * simultaneousState.scale
    }
    
    public var conteudo : String
    @State var text: String = "Clique aqui para adicionar o texto"
    @State private var height: CGFloat = .zero
    @State private var width: CGFloat = .zero
    
    @State private var rectPosition = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    @State private var degree = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    @State var buttonIsShowing = false
    
    
    init(conteudo:String){
        //Remove the default background of the TextEditor/UITextView
        UITextView.appearance().isScrollEnabled = false
        UITextView.appearance().backgroundColor = .clear
        print(conteudo)
        self.conteudo = conteudo
        print(self.conteudo)
        
    }
    
    var body: some View {
        if isShowingTextView {
            let magnificationGesture = MagnificationGesture()
            
            let rotationGesture = RotationGesture(minimumAngleDelta: Angle(degrees: 5))
            
            let simultaneous = SimultaneousGesture(magnificationGesture, rotationGesture)
                .updating($simultaneousState) { value, state, transation in
                    if value.first != nil && value.second != nil {
                        state = .both(angle: value.second!, scale: value.first!)
                    } else if value.first != nil {
                        state = .zooming(scale: value.first!)
                    } else if value.second != nil {
                        state = .rotating(angle: value.second!)
                    } else {
                        state = .inactive
                    }
                }.onEnded { value in
                    self.viewMagnificationState *= value.first ?? 1
                    self.viewRotationState += value.second ?? Angle.zero
                }
            
            
            
            
            VStack(alignment: .center) {
                
                ZStack (alignment: .top){
                    TextEditor(text: $text)
                        .frame(width: width + 12, height: height + 12)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        
                    
                    
                    Text(text)
                        .onDrag {
                            NSItemProvider(object: text as NSString)
                        }
                        .background(GeometryReader {
                            Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                            Color.clear.preference(key: ViewWidthKey.self, value: $0.frame(in: .local).size.width)
                        })
                        .frame(maxWidth: 500)
                        .multilineTextAlignment(.center)
                        .opacity(0)
                    
                    HStack{
                        Spacer()
                        if buttonIsShowing{
                            Button(action: {
                                withAnimation{
                                    isShowingTextView = false
                                }
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.blueColor)
                            })
                        }
                    }.frame(width: width + 70, height: height + 12)
                    
                }.rotationEffect(rotationAngle)
                .scaleEffect(magnificationScale)
                .position(rectPosition)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.rectPosition = value.location
                        }
                )
                .gesture(simultaneous)
                .onPreferenceChange(ViewHeightKey.self) { height = $0 }
                .onPreferenceChange(ViewWidthKey.self) { width = $0 }
                
                
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            //        .background(Color.black.onTapGesture {
            //            self.endTextEditing()
            //        }) // coloquei aqui porque o de baixo nao tava pegando kkkkk
            .onTapGesture {
                self.endTextEditing()
                buttonIsShowing.toggle()
            }
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
