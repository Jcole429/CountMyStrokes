//
//  HoleInputSection.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 7/1/21.
//

import SwiftUI

struct HoleInputSection: View {
    var label: String
    var button1Image: Image
    var button1Action: () -> Void
    var button2Image: Image
    var Button2Action: () -> Void
    
    var body: some View {
        EqualCenter(firstView: AnyView(Text(label)), secondView: AnyView(
            HStack {
                Button(action: button1Action) {
                    button1Image
                }.padding(.horizontal, 10)
                Button(action: Button2Action) {
                    button2Image
                }.padding(.horizontal, 10)
            }
        ))
    }
}

struct HoleInputSection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HoleInputSection(label: "General:", button1Image: Image(systemName:"plus"), button1Action: {print("hi")}, button2Image: Image(systemName: "minus")) {print("hit")}
            HoleInputSection(label: "General:", button1Image: Image(systemName:"plus"), button1Action: {print("hi")}, button2Image: Image(systemName: "minus")) {print("hit")}
        }
    }
}
