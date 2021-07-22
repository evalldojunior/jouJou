//
//  jouJouApp.swift
//  jouJou
//
//  Created by Dara Caroline on 06/07/21.
//

import SwiftUI

@main
struct jouJouApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //Introduction()
            //SelectStyle(name: "Evaldo")
            Humor()
            //Home()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
