//
//  Stepper1.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct Stepper1: View {
    
    let label: String
    @Binding var passedVar: Int
    
    var body: some View {
        EqualCenter(
            firstView: AnyView(Text("\(label)")),
            secondView: AnyView(
                HStack {
                    Text("\(passedVar)")
                    Stepper("", value: $passedVar, in: 0...99).labelsHidden()
                }
                
            )
        )
    }
}

struct Stepper1_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
//            Stepper1(label: "Hello World how are", passedVar: $10)
//            Stepper1(label: "Hello World", passedVar: $10)
        }
    }
}
