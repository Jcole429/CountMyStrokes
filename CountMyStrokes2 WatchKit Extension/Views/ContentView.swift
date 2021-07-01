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
            Text("Score: \(gameManager.getCurrentHole().totalStrokesTaken)")
            HStack{
                Text("Hole# \(model.gameManager.currentHoleIndex + 1)")
                Spacer()
                Text("Strokes: \(model.gameManager.getCurrentHole().totalStrokesTaken)")
            }
            HStack{
                Button1(labelText: "General: \(model.gameManager.getCurrentHole().strokesTaken)") {
                    print("Short Press")
                    print("Strokes taken: \(model.gameManager.getCurrentHole().strokesTaken)")
//                    model.objectWillChange.send()
                    model.gameManager.incrementCurrentHoleStrokesTaken()
                } longPressAction: {
                    model.gameManager.decrementCurrentHoleStrokesTaken()
                }
                Button1(labelText: "Chips: \(model.gameManager.getCurrentHole().chipsTaken)") {
                    print("Short Press")
                } longPressAction: {
                    print("Long Press")
                }
            }
            Spacer()
            HStack{
                Button1(labelText: "Puts: \(model.gameManager.getCurrentHole().putsTaken)") {
                    print("Short Press")
                } longPressAction: {
                    print("Long Press")
                }
                Button1(labelText: "Penalties: \(model.gameManager.getCurrentHole().penaltiesTaken)") {
                    print("Short Press")
                } longPressAction: {
                    print("Long Press")
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
