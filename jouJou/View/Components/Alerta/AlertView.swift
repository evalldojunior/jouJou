//
//  MyView.swift
//  jouJou
//
//  Created by Alexandra Zarzar on 20/07/21.
//

import SwiftUI

struct AlertView: View {
    @Binding var alertIsPresented: Bool
      @Binding var text: String? // this is updated as the user types in the text field

      var body: some View {
        Text("My Demo View")
          .textFieldAlert(isPresented: $alertIsPresented) { () -> TextFieldAlert in
            TextFieldAlert(title: "Alert Title", message: "Alert Message", text: self.$text)
        }
      }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alertIsPresented: .constant(true), text: .constant("alert"))
    }
}
