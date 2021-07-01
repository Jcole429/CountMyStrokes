//
//  CountMyStrokes2App.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

@main
struct CountMyStrokes2App: App {
    
    @ObservedObject var model = ViewModelPhone()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
