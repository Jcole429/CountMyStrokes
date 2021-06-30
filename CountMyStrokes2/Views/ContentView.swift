//
//  ContentView.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var model = ViewModelPhone()
    @State var reachable = "No"
    var body: some View {
        Text("Reachable \(reachable)")
                    
                    Button(action: {
                        if self.model.session.isReachable {
                            self.reachable = "Yes"
                        }
                        else{
                            self.reachable = "No"
                        }
                        
                    }) {
                        Text("Update")
                    }
//        VStack {
//            Spacer()
//            ZStack{
//                Color(.darkGray)
//                    .cornerRadius(8)
//                    .opacity(0.5)
//                    .padding(.horizontal, 30)
//                VStack {
//                    HoleInfoView().environmentObject(gameManager)
//                }
//            }
//            Spacer()
//            VStack() {
//                Spacer()
//                Button(action: {}, label: {
//                    Button1(label: "New Game") {
//                        gameManager.newGame()
//                    }
//                })
//                Spacer()
//                HStack() {
//                    Button1(label: "Hole \(gameManager.currentHoleIndex)") {
//                        _ = gameManager.previousHole()
//                        print(gameManager.getCurrentHole().strokesTaken)
//                        print(gameManager.getCurrentHole().totalStrokesTaken)
//                    }
//                    .frame(width: 150)
//                    .padding(.leading, 20)
//                    Spacer()
//                    Button1(label: "Hole #\(gameManager.currentHoleIndex + 2)") {
//                        _ = gameManager.nextHole()
//                    }
//                    .frame(width: 150)
//                    .padding(.trailing, 20)
//                }
//                Spacer()
//            }
//        }.background(
//            Image("golf-background")
//                .resizable()
//                .ignoresSafeArea()
//                .scaledToFill()
//        )
//    }
}
}

let gameManagerPreview = GameManager()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(gameManagerPreview)
            .previewDevice("iPhone 8")
        
    }
}
