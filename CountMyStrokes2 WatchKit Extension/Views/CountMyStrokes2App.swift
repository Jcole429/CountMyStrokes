//
//  CountMyStrokes2App.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

@main
struct CountMyStrokes2App: App {
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
