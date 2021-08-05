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
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            //Introduction()
            //SelectStyle(name: "Evaldo")
            Humor()
           // Home()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

            //Calendar()
        }
        .onChange(of: scenePhase){ (newScenePhase) in
            switch newScenePhase{
            case .background:
                print("is in background")

                persistenceController.save()
            case .inactive:
                print("is inactive")
            case .active:
                print("is active")

            @unknown default:
                print("default")

            }
    }
}
}
