//
//  ContentView.swift
//  jouJou
//
//  Created by Dara Caroline on 06/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View{
        VStack{
            Text("some view")
        }
    }
    
    
    
    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

