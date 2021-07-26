//
//  MiniGolfWatchView.swift
//  CountMyStrokes WatchKit Extension
//
//  Created by Justin Cole on 7/6/21.
//

import SwiftUI

struct WatchMiniGolfView: View {
    
    @EnvironmentObject var model: WCWatch
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    model.objectWillChange.send()
                    model.miniGolfGameManager.previousHole()
                    model.updatePhoneMiniGolf()
                }) {
                    Image(systemName: "chevron.backward")
                }
                Text("Hole # \(model.miniGolfGameManager.game.currentHoleIndex + 1)")
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .layoutPriority(1)
                Button(action: {
                    model.objectWillChange.send()
                    model.miniGolfGameManager.nextHole()
                    model.updatePhoneMiniGolf()
                }) {
                    Image(systemName: "chevron.forward")
                }
            }
            List {
                ForEach(model.miniGolfGameManager.game.players, id: \.playerId) { player in
                    HStack() {
                        Text("\(player.name)\n \(model.miniGolfGameManager.getPlayerStrokes(playerId: player.playerId))")
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        HStack(spacing: 10) {
                            Button(action: {
                                model.objectWillChange.send()
                                model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: -1)
                                model.updatePhoneMiniGolf()
                            }) {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .buttonStyle(ButtonStyle1())
                            Button(action: {
                                model.objectWillChange.send()
                                model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: 1)
                                model.updatePhoneMiniGolf()
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                            }.buttonStyle(ButtonStyle1())
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct MiniGolfWatchView_Previews: PreviewProvider {
    static var previews: some View {
        let testModel = WCWatch()
        testModel.miniGolfGameManager.addPlayer(playerName: "Justin")
        testModel.miniGolfGameManager.addPlayer(playerName: "Bohdan")
        testModel.miniGolfGameManager.addPlayer(playerName: "Stephen")
        testModel.miniGolfGameManager.addPlayer(playerName: "Jeikhunnnnnn")
        return WatchMiniGolfView().environmentObject(testModel)
    }
}
