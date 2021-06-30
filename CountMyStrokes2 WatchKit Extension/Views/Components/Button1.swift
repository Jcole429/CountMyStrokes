//
//  Button1.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/30/21.
//

import SwiftUI

struct Button1: View {
    @State private var didLongPress = false
    
    var labelText: String
    let shortPressAction: () -> Void
    let longPressAction: () -> Void
    
    var body: some View {
        Button(labelText) {
            if self.didLongPress {
                self.didLongPress = false
                longPressAction()
            } else {
                shortPressAction()
            }
        }.simultaneousGesture(
            LongPressGesture().onEnded { _ in self.didLongPress = true }
        )
        .buttonStyle(ButtonStyle1())
    }
}

struct Button1_Previews: PreviewProvider {
    static var previews: some View {
        Button1(labelText: "Penalties: 10") {
            print("Short Press")
        } longPressAction: {
            print("Long Press")
        }
    }
}
