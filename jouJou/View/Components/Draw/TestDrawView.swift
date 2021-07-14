//
//  DesenhoView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 08/07/21.
//

import SwiftUI
import PencilKit


struct TestDrawView: View {
    
    @State private var drawingView = PKCanvasView()
    
    var body: some View {
        DrawingView(drawingView: $drawingView)
    }
}

struct DesenhoView_Previews: PreviewProvider {
    static var previews: some View {
        TestDrawView()
    }
}
