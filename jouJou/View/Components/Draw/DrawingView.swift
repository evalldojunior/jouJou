//
//  CanvasView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 08/07/21.
//

import SwiftUI
import PencilKit


struct DrawingView {
    @State var toolPicker = PKToolPicker()
    @Binding var showingToolPicker: Bool
    @Binding var drawingView: PKCanvasView
 
}

private extension DrawingView {
    func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: drawingView)
        toolPicker.addObserver(drawingView)
        drawingView.becomeFirstResponder()
    }
    func NotshowToolPicker() {
        toolPicker.setVisible(false, forFirstResponder: drawingView)
        toolPicker.removeObserver(drawingView)
    }

    
}

extension DrawingView: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        //#if targetEnvironment(simulator)     Apaguei porque "If you want to support finger drawing in general, remove the conditional compilation instructions.
        drawingView.drawingPolicy = .default
        //#endif
        drawingView.backgroundColor = .clear
        drawingView.isOpaque = false
        return drawingView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if showingToolPicker{
        showToolPicker()
        }else{
            NotshowToolPicker()
            self.drawingView.drawingGestureRecognizer.isEnabled = false
        }
    }

}
