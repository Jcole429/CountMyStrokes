//
//  CountMyStrokesApp.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

@main
struct CountMyStrokesApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @ObservedObject var model = WCPhone()
    
    var body: some Scene {
        WindowGroup {
            MainMenuView().environmentObject(model)
        }.onChange(of: scenePhase) { (newScenePhase) in
            switch newScenePhase {
            case .active:
                print("scene is now active!")
            case .inactive:
                print("scene is now inactive!")
                print("saving gameManager")
                self.model.golfGameManager.saveGame()
                self.model.miniGolfGameManager.saveGame()
            case .background:
                print("scene is now in the background!")
            @unknown default:
                print("Apple must have added something new!")
            }
        }
    }
}
