//
//  CountMyStrokes2App.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

@main
struct CountMyStrokes2App: App {
    
    @ObservedObject var model = WCWatch()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                if model.gameMode == GameMode.golfMode {
                    WatchGolfView().environmentObject(model)
                } else {
                    WatchMiniGolfView().environmentObject(model)
                }
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
