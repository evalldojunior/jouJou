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
    @Binding var drawingView: PKCanvasView
}

private extension DrawingView {
  func showToolPicker() {
    toolPicker.setVisible(true, forFirstResponder: drawingView)
    toolPicker.addObserver(drawingView)
    drawingView.becomeFirstResponder()
  }
}

extension DrawingView: UIViewRepresentable {
  func makeUIView(context: Context) -> PKCanvasView {
    showToolPicker()
    //#if targetEnvironment(simulator)     Apaguei porque "If you want to support finger drawing in general, remove the conditional compilation instructions.
      drawingView.drawingPolicy = .anyInput
    //#endif
    return drawingView
  }

  func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

