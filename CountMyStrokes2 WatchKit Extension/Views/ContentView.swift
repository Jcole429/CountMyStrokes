//
//  ContentView.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ViewModelWatch()
    
    @State private var didLongPress = false
    
    var body: some View {
        let gameManager = model.gameManager
        let detectDirectionalDrags = DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
        .onEnded { value in
            print(value.translation)
            
            if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                print("left swipe")
                model.objectWillChange.send()
                _ = model.gameManager.nextHole()
                model.updatePhone()
            }
            else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                print("left right")
                model.objectWillChange.send()
                _ = model.gameManager.previousHole()
                model.updatePhone()
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
                Text("Hole# \(model.gameManager.currentHoleIndex + 1)")
                Spacer()
                Text("Strokes: \(model.gameManager.getCurrentHole().totalStrokesTaken)")
            }
            HStack{
                Button1(labelText: "General:\n \(model.gameManager.getCurrentHole().strokesTaken)") {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHoleStrokesTaken()
                    model.updatePhone()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHoleStrokesTaken()
                    model.updatePhone()
                }
                Button1(labelText: "Chips:\n \(model.gameManager.getCurrentHole().chipsTaken)") {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHoleChipsTaken()
                    model.updatePhone()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHoleChipsTaken()
                    model.updatePhone()
                }
            }
            Spacer()
            HStack{
                Button1(labelText: "Puts:\n \(model.gameManager.getCurrentHole().putsTaken)") {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHolePutsTaken()
                    model.updatePhone()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHolePutsTaken()
                    model.updatePhone()
                }
                Button1(labelText: "Penalties:\n \(model.gameManager.getCurrentHole().penaltiesTaken)") {
                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHolePenaltiesTaken()
                    model.updatePhone()
                } longPressAction: {
                    model.objectWillChange.send()
                    model.gameManager.decrementCurrentHolePenaltiesTaken()
                    model.updatePhone()
                }
            }
        }.gesture(detectDirectionalDrags)
    }
}

struct ContentView_Previews: PreviewProvider {
    var model = ViewModelWatch()
    static var previews: some View {
        ContentView()
            .previewDevice("Apple Watch Series 6 - 40mm")
    }
}
