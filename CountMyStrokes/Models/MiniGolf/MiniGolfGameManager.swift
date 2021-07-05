//
//  MiniGolfGameManager.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import Foundation

class MiniGolfGameManager: GameManagerProtocol, ObservableObject {
    
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("MiniGolfGame.plist")
    
    @Published var game = MiniGolfGame()
    
    func saveGame() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.game)
            try data.write(to: MiniGolfGameManager.dataFilePath!)
        } catch {
            print("Error saving mini golf game, \(error)")
        }
    }
    
    func loadGame() {
        if let data = try? Data(contentsOf: GolfGameManager.dataFilePath!) {
            print("Loading mini golf game")
            self.importData(data: data)
        } else {
            print("Error loading mini golf game")
        }
    }
    
    func importData(data: Data) {
        let decoder = PropertyListDecoder()
        do {
            let updatedGame = try decoder.decode(MiniGolfGame.self, from: data)
            self.objectWillChange.send()
            self.game = updatedGame
            print("Imported mini golf game data")
        } catch {
            print("Error decoding mini golf game data, \(error)")
        }
    }
    
    func getData() -> Data? {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.game)
            return data
        } catch {
            return nil
        }
    }
    
    func addPlayer(playerName: String) {
        self.game.players.append(Player(playerId: self.game.players.count, name: playerName))
    }
    
    func updatePlayerNums() {
        for i in 0..<self.game.players.count {
            self.game.players[i].playerId = i
        }
    }
    
    func updatePlayerStrokes(playerId: Int, incrementBy val: Int) {
        self.game.players[playerId].holes[self.game.currentHoleIndex].strokesTaken += val
    }
    
    func getPlayerStrokes(playerId: Int) -> Int {
        self.game.players[playerId].holes[self.game.currentHoleIndex].strokesTaken
    }
}
