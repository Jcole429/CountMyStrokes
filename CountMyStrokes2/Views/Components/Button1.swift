//
//  Button1UIView.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct Button1: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: self.action, label: {
            Text(label)
                .font(.title2)
                .foregroundColor(.white)
        })
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(UIColor.systemGreen))
        .cornerRadius(8)
    }
}

struct Button1_Previews: PreviewProvider {
    static var previews: some View {
        Button1(label: "Hello World", action: {})
    }
}
