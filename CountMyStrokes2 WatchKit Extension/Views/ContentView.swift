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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    var model = ViewModelWatch()
    static var previews: some View {
        ContentView()
            .previewDevice("Apple Watch Series 6 - 40mm")
    }
}
