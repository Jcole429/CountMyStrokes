//
//  EqualCenter.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct EqualCenter: View {
    let firstView: AnyView
    let secondView: AnyView
    
    var body: some View {
        HStack(spacing: 10) {
            HStack {
                Spacer()
                firstView
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            HStack {
                secondView
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct EqualCenter_Previews: PreviewProvider {
    static var previews: some View {
        EqualCenter(firstView: AnyView(Text("View 1")), secondView: AnyView(Text("Much Longer View 2")))
    }
}
