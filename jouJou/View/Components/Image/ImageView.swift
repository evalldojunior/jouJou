//
//  ImageView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 13/07/21.
//

import SwiftUI

struct ImageView: View {
    var image: Image?
    
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
    @GestureState var simultaneousState = SimultaneousState.inactive
    @State var viewRotationState = Angle.zero
    @State var viewMagnificationState = CGFloat(1.0)
    
    var rotationAngle: Angle {
        return viewRotationState + simultaneousState.rotationAngle
    }
    
    var magnificationScale: CGFloat {
        return viewMagnificationState * simultaneousState.scale
    }
    
    
    @State private var height: CGFloat = .zero
    @State private var width: CGFloat = .zero
    
    @State private var rectPosition = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    @State private var degree = 0.0
    @State var lastScaleValue: CGFloat = 1.0
    
    
    var body: some View {
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
        ZStack{
            if image != nil {
                image?
                    .resizable()
                    .frame(width: 200, height: 200)
                    .rotationEffect(rotationAngle)
                    .scaleEffect(magnificationScale)
                    .position(rectPosition)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.rectPosition = value.location
                            }
                    )
                    .gesture(simultaneous)
            }
            
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
