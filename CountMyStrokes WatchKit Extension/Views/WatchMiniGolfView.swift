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
            List {
                ForEach(model.miniGolfGameManager.game.players, id: \.playerId) { player in
                    HStack {
                        HStack {
                            Text("\(player.name): \(model.miniGolfGameManager.getPlayerStrokes(playerId: player.playerId))")
                        }
                        HStack {
                            Button(action: {
                                model.objectWillChange.send()
                                model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: -11)
                                model.updatePhoneMiniGolf()
                            }) {
                                Image(systemName: "minus").resizable().scaledToFit()
                            }
                            Button(action: {
                                model.objectWillChange.send()
                                model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: 1)
                                model.updatePhoneMiniGolf()
                            }) {
                                Image(systemName: "plus").resizable().scaledToFit()
                            }
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
        testModel.miniGolfGameManager.addPlayer(playerName: "Christinaaa")
        testModel.miniGolfGameManager.addPlayer(playerName: "Christinaaa")
        return WatchMiniGolfView().environmentObject(testModel)
    }
}
	
