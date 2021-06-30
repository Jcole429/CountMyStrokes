//
//  HoleInfoUIView.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct HoleInfoView: View {
//    @ObservedObject var hole: Hole
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Total Score: \(gameManager.game.totalScore)")
            Text("Hole #\(gameManager.getCurrentHole().holeNumber)")
            Text("Hole Strokes: \(gameManager.getCurrentHole().totalStrokesTaken)")
            Stepper1(label: "General:", passedVar: $gameManager.game.holes[gameManager.currentHoleIndex].strokesTaken)
            Stepper1(label: "Chips:", passedVar: $gameManager.game.holes[gameManager.currentHoleIndex].chipsTaken)
            Stepper1(label: "Puts:", passedVar: $gameManager.game.holes[gameManager.currentHoleIndex].putsTaken)
            Stepper1(label: "Penalties:", passedVar: $gameManager.game.holes[gameManager.currentHoleIndex].penaltiesTaken)
            EqualCenter(firstView: AnyView(Text("Green in Regulation:")), secondView: AnyView(
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "checkmark.circle")
                    }.padding(.horizontal, 10)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "xmark.circle")
                    }.padding(.horizontal, 10)
                }
            ))
        }
        .padding(.horizontal, 50)
        .foregroundColor(.white)
        .font(.title3)
    }
}


struct HoleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.darkGray)
                .cornerRadius(8)
                .opacity(0.5)
                .padding(.horizontal, 30)
            HoleInfoView().environmentObject(gameManagerPreview)
        }
    }
}

