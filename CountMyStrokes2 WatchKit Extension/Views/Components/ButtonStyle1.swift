//
//  ButtonStyle1.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/30/21.
//

import Foundation
import SwiftUI

struct ButtonStyle1: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(PlainButtonStyle())
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.1333017349, green: 0.1332704723, blue: 0.1373922825, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .multilineTextAlignment(.center)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
    
}
