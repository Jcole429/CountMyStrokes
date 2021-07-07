//
//  MiniGolfMode.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import SwiftUI

struct MiniGolfModeView: View {
    
    @EnvironmentObject var model: WatchConnectivityPhone
    
    @State var newGamePressed = false
    
    func deleteItems(at offsets: IndexSet) {
        model.objectWillChange.send()
        model.miniGolfGameManager.game.players.remove(atOffsets: offsets)
        model.miniGolfGameManager.updatePlayerNums()
    }
    
    var body: some View {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        return ZStack {
            Color.clear.overlay(
                Image("golf-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Text("Hole #\(model.miniGolfGameManager.game.currentHoleIndex + 1)")
                        .font(.largeTitle)
                    Spacer()
                    List {
                        ForEach(model.miniGolfGameManager.game.players, id: \.playerId) { player in
                            HoleInputSection(label: "\(player.name):  \(model.miniGolfGameManager.getPlayerStrokes(playerId: player.playerId))", button1ImageView: AnyView(Image(systemName: "minus")), button1Action: {
                                model.objectWillChange.send()
                                model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: -1)
                            }, button2ImageView: AnyView(Image(systemName: "plus"))) {
                                model.objectWillChange.send()
                                model.miniGolfGameManager.updatePlayerStrokes(playerId: player.playerId, incrementBy: 1)
                            }.listRowBackground(Color.clear)
                        }
                        .onDelete(perform: deleteItems)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color(.darkGray)
                                .opacity(0.7)
                                .cornerRadius(8))
                
                Spacer()
                VStack {
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
                                    model.miniGolfGameManager.newGame()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    })
                    Spacer()
                    HStack {
                        Button1(label: "Hole #\(model.miniGolfGameManager.game.currentHoleIndex)") {
                            model.objectWillChange.send()
                            model.miniGolfGameManager.previousHole()
                        }.opacity(model.miniGolfGameManager.game.currentHoleIndex > 0 ? 1 : 0)
                        Spacer()
                        Button1(label: "Hole #\(model.miniGolfGameManager.game.currentHoleIndex + 2)") {
                            model.objectWillChange.send()
                            model.miniGolfGameManager.nextHole()
                        }.opacity(model.miniGolfGameManager.game.currentHoleIndex < 17 ? 1 : 0)
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    Text("Golf Vectors by Vecteezy")
                        .padding(.trailing)
                        .foregroundColor(.white)
                    
                }
            }
            .padding(.horizontal)
            .foregroundColor(.white)
        }
        .toolbar(content: {
            NavigationLink(
                destination: AddPlayerView().environmentObject(model),
                label: {
                    Text("Add Player")
                        .foregroundColor(.white)
                    
                }).disabled(false).grayscale(0.8)
        }).onAppear(perform: {
            model.updateGameMode(gameMode: GameMode.miniGolfMode)
            model.updateWatchGameMode()
            print("Updated mode to miniGolfMode")
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
