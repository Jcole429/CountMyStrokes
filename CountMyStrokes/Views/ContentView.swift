//
//  ContentView.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: WatchConnectivityPhone
    
    @State var newGamePressed = false
    
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
                    ZStack{
                        Color(.darkGray)
                            .cornerRadius(8)
                            .opacity(0.5)
                        VStack {
                            Spacer()
                            Text("Score:").font(.title)
                            Text("\(model.golfGameManager.game.totalScore)").font(.largeTitle)
                            Spacer()
                            Text("Hole #\(model.golfGameManager.getCurrentHole().holeNumber)").font(.title)
                            Text("Hole Strokes: \(model.golfGameManager.getCurrentHole().totalStrokesTaken)").font(.title)
                            Spacer()
                            HoleInputView().environmentObject(model)
                            Spacer()
                        }.foregroundColor(.white)
                    }
                    VStack() {
                        Spacer()
                        Button(action: {}, label: {
                            Button1(label: "New Game") {
                                newGamePressed = true
                            }.alert(isPresented:$newGamePressed) {
                                Alert(
                                    title: Text("New Game?"),
                                    message: Text("All data will be lost."),
                                    primaryButton: .destructive(Text("New Game")) {
                                        model.objectWillChange.send()
                                        model.golfGameManager.newGame()
                                        model.updateWatchGolf()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        })
                        Spacer()
                        HStack() {
                            Button1(label: "Hole \(model.golfGameManager.game.currentHoleIndex)") {
                                model.objectWillChange.send()
                                _ = model.golfGameManager.previousHole()
                                model.updateWatchGolf()
                            }.opacity(model.golfGameManager.game.currentHoleIndex > 0 ? 1 : 0)
                            Spacer()
                            Button1(label: "Hole #\(model.golfGameManager.game.currentHoleIndex + 2)") {
                                model.objectWillChange.send()
                                _ = model.golfGameManager.nextHole()
                                model.updateWatchGolf()
                            }.opacity(model.golfGameManager.game.currentHoleIndex < 17 ? 1 : 0)
                        }
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 30)
                HStack{
                    Spacer()
                    Text("Golf Vectors by Vecteezy")
                        .padding(.trailing)
                        .foregroundColor(.white)
                    
                }
            }
        }
    }
}

let model = WatchConnectivityPhone()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(model)
            .previewDevice("iPhone 8")
        
    }
}
