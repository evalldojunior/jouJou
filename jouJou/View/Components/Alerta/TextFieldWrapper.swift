//
//  TextFieldWrapper.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 20/07/21.
//

import SwiftUI

struct TextFieldWrapper<PresentingView: View>: View {

  @Binding var isPresented: Bool
  let presentingView: PresentingView
  let content: () -> TextFieldAlert

  var body: some View {
    ZStack {
      if (isPresented) { content().dismissable($isPresented) }
      presentingView
    }
  }
}
