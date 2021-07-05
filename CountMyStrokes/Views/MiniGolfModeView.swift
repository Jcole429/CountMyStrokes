//
//  MiniGolfMode.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import SwiftUI

struct MiniGolfModeView: View {
    
    @EnvironmentObject var model: WatchConnectivityPhone
    
    func deleteItems(at offsets: IndexSet) {
        model.objectWillChange.send()
        model.miniGolfGameManager.game.players.remove(atOffsets: offsets)
        model.miniGolfGameManager.updatePlayerNums()
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(model.miniGolfGameManager.game.players, id: \.playerId) { player in
                        HoleInputSection(label: "\(player.name):  \(model.miniGolfGameManager.getPlayerStrokes(playerId: player.playerId))", button1ImageView: AnyView(Image(systemName: "minus")), button1Action: {
                            model.objectWillChange.send()
                            model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: -1)
                        }, button2ImageView: AnyView(Image(systemName: "plus"))) {
                            model.objectWillChange.send()
                            model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: 1)
                        }
                }
                .onDelete(perform: deleteItems)
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .navigationBarTitle("Mini Golf Mode")
        .toolbar(content: {
            NavigationLink(
                destination: AddPlayerView().environmentObject(model),
                label: {
                    Text("Add Player")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color(UIColor.systemGreen))
                        .cornerRadius(8)
                }).disabled(false).grayscale(0.8)
        })
    }
}

struct MiniGolfMode_Previews: PreviewProvider {
    
    static var previews: some View {
        let testModel = WatchConnectivityPhone()
        testModel.miniGolfGameManager.addPlayer(playerName: "Justin")
        testModel.miniGolfGameManager.addPlayer(playerName: "Bohdan")
        return MiniGolfModeView().environmentObject(testModel)
    }
}
