//
//  ContentView.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ViewModelPhone
    
    @State var reachable = "No"
    @State var messageText = ""
    
    var body: some View {
        ZStack {
            Color.clear.overlay(
                Image("golf-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Spacer()
                    ZStack{
                        Color(.darkGray)
                            .cornerRadius(8)
                            .opacity(0.5)
                        VStack {
                            Spacer()
                            Text("Score:").font(.title)
                            Text("\(model.gameManager.game.totalScore)").font(.largeTitle)
                            Spacer()
                            Text("Hole #\(model.gameManager.getCurrentHole().holeNumber)").font(.title)
                            Text("Hole Strokes: \(model.gameManager.getCurrentHole().totalStrokesTaken)").font(.title)
                            Spacer()
                            HoleInputView().environmentObject(model)
                            Spacer()
                        }.foregroundColor(.white)
                    }
                    VStack() {
                        Spacer()
                        Button(action: {}, label: {
                            Button1(label: "New Game") {
                                model.objectWillChange.send()
                                model.gameManager.newGame()
                                model.updateWatch()
                            }
                        })
                        Spacer()
                        HStack() {
                            Button1(label: "Hole \(model.gameManager.currentHoleIndex)") {
                                model.objectWillChange.send()
                                _ = model.gameManager.previousHole()
                                model.updateWatch()
                            }.opacity(model.gameManager.currentHoleIndex > 0 ? 1 : 0)
                            Spacer()
                            Button1(label: "Hole #\(model.gameManager.currentHoleIndex + 2)") {
                                model.objectWillChange.send()
                                _ = model.gameManager.nextHole()
                                model.updateWatch()
                            }.opacity(model.gameManager.currentHoleIndex < 17 ? 1 : 0)
                        }
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 30)
                HStack{
                    Spacer()
                    Text("Golf Vectors by Vecteezy").padding(.trailing)
                }
            }
        }
    }
}

let model = ViewModelPhone()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(model)
            .previewDevice("iPhone 8")
        
    }
}
