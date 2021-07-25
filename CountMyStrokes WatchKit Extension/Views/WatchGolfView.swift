//
//  ContentView.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct WatchGolfView: View {
    @EnvironmentObject var model: WCWatch
    
    @State private var didLongPress = false
    
    var body: some View {
        let gameManager = model.golfGameManager
        let detectDirectionalDrags = DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
        .onEnded { value in
            print(value.translation)
            
            if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                print("left swipe")
                model.objectWillChange.send()
                _ = model.golfGameManager.nextHole()
                model.updatePhoneGolf()
            }
            else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                print("left right")
                model.objectWillChange.send()
                _ = model.golfGameManager.previousHole()
                model.updatePhoneGolf()
            }
            else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                print("up swipe")
            }
            else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                print("down swipe")
            }
            else {
                print("no clue")
            }
        }
        
        VStack(alignment: .leading) {
            Text("Score: \(gameManager.game.totalScore)")
            HStack{
                Text("Hole# \(model.golfGameManager.game.currentHoleIndex + 1)")
                Spacer()
                Text("Strokes: \(model.golfGameManager.getCurrentHole().totalStrokesTaken)")
            }
            Spacer()
            HStack{
                Button1(labelText: "General:\n \(model.golfGameManager.getCurrentHole().strokesTaken)") {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHoleStrokesTaken()
                    model.updatePhoneGolf()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHoleStrokesTaken()
                    model.updatePhoneGolf()
                }
                Button1(labelText: "Chips:\n \(model.golfGameManager.getCurrentHole().chipsTaken)") {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHoleChipsTaken()
                    model.updatePhoneGolf()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHoleChipsTaken()
                    model.updatePhoneGolf()
                }
            }
            Spacer()
            HStack{
                Button1(labelText: "Puts:\n \(model.golfGameManager.getCurrentHole().putsTaken)") {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHolePutsTaken()
                    model.updatePhoneGolf()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHolePutsTaken()
                    model.updatePhoneGolf()
                }
                Button1(labelText: "Penalties:\n \(model.golfGameManager.getCurrentHole().penaltiesTaken)") {
                    model.objectWillChange.send()
                    model.golfGameManager.incrementCurrentHolePenaltiesTaken()
                    model.updatePhoneGolf()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.golfGameManager.decrementCurrentHolePenaltiesTaken()
                    model.updatePhoneGolf()
                }
            }
        }.gesture(detectDirectionalDrags)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = WCWatch()
        WatchGolfView().environmentObject(model)
            .previewDevice("Apple Watch Series 6 - 40mm")
    }
}
