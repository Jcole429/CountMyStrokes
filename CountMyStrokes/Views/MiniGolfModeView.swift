//
//  MiniGolfMode.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import SwiftUI

struct MiniGolfModeView: View {
    
    @EnvironmentObject var model: WatchConnectivityPhone
    
    
    var body: some View {
        NavigationView {
            Text("Mini Golf Time")
                .navigationBarTitle("Mini Golf Mode")
        }
    }
}

struct MiniGolfMode_Previews: PreviewProvider {
    static var previews: some View {
        MiniGolfModeView()
    }
}
