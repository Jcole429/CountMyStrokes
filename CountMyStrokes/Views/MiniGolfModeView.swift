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
            VStack(spacing: 0) {
                VStack {
                    ZStack {
                        Color(.darkGray)
                            .cornerRadius(8)
                            .opacity(0.5)
                        VStack {
                            Text("Hole #\(model.miniGolfGameManager.game.currentHoleIndex + 1)")
                                .font(.largeTitle)
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
                            }.background(Color.clear)
                        }
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 30)
                .foregroundColor(.white)
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
                    Spacer()
                    Button1(label: "Hole #\(model.miniGolfGameManager.game.currentHoleIndex)") {
                        model.objectWillChange.send()
                        model.miniGolfGameManager.previousHole()
                    }.opacity(model.miniGolfGameManager.game.currentHoleIndex > 0 ? 1 : 0)
                    Spacer()
                    Button1(label: "Hole #\(model.miniGolfGameManager.game.currentHoleIndex + 2)") {
                        model.objectWillChange.send()
                        model.miniGolfGameManager.nextHole()
                    }.opacity(model.miniGolfGameManager.game.currentHoleIndex < 17 ? 1 : 0)
                    Spacer()
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
}

struct MiniGolfMode_Previews: PreviewProvider {
    
    static var previews: some View {
        let testModel = WatchConnectivityPhone()
        testModel.miniGolfGameManager.addPlayer(playerName: "Justin")
        testModel.miniGolfGameManager.addPlayer(playerName: "Bohdan")
        return MiniGolfModeView().environmentObject(testModel)
    }
}
