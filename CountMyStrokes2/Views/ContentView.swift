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
                Spacer()
                ZStack{
                    Color(.darkGray)
                        .cornerRadius(8)
                        .opacity(0.5)
                        .padding(.horizontal, 30)
                    VStack {
                        Spacer()
                        Text("Score:")
                        Text("\(model.gameManager.game.totalScore)").font(.title)
                        Spacer()
                        HoleInfoView().environmentObject(model)
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
                        }
                        .frame(width: 150)
                        .padding(.leading, 20)
                        Spacer()
                        Button1(label: "Hole #\(model.gameManager.currentHoleIndex + 2)") {
                            model.objectWillChange.send()
                            _ = model.gameManager.nextHole()
                            model.updateWatch()
                        }
                        .frame(width: 150)
                        .padding(.trailing, 20)
                    }
                    Spacer()
                }
            }.frame(width: UIScreen.main.bounds.width - 60, height:  UIScreen.main.bounds.height-60)
        }
    }
}

let model = ViewModelPhone()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(model)
            .previewDevice("iPhone 12 Pro Max")
        
    }
}
