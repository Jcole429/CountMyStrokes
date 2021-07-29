//
//  HoleInputSection.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 7/1/21.
//

import SwiftUI

struct HoleInputSection: View {
    var label: String
    var button1ImageView: AnyView
    var button1Action: () -> Void
    var button2ImageView: AnyView
    var Button2Action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Text(label)
            
            Button(action: button1Action) {
                button1ImageView.frame(width: 50, height: 50)
            }
            Button(action: Button2Action) {
                button2ImageView.frame(width: 50, height: 50)
            }
        }
    }
}

struct HoleInputSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HoleInputSection(label: "General:", button1ImageView: AnyView(Image(systemName:"plus")), button1Action: {print("hi")}, button2ImageView: AnyView(Image(systemName: "minus"))) {print("hit")}
            HoleInputSection(label: "General:", button1ImageView: AnyView(Image(systemName:"plus")), button1Action: {print("hi")}, button2ImageView: AnyView(Image(systemName: "minus"))) {print("hit")}
        }
    }
}
