//
//  CountMyStrokes2App.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

@main
struct CountMyStrokes2App: App {
    
    @ObservedObject var model = ViewModelWatch()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                if model.gameMode == GameMode.golfMode {
                    WatchGolfView().environmentObject(model)
                } else {
                    WatchMiniGolfView()
                }
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
