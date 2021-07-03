//
//  MiniGolfGameManager.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import Foundation

class MiniGolfGameManager: GameManagerProtocol, Codable, ObservableObject {
    
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("MiniGolfGame.plist")
    
    @Published var game = MiniGolfGame()
    
    enum ChildKeys: CodingKey {
        case game
    }
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildKeys.self)
        self.game = try container.decode(MiniGolfGame.self, forKey: .game)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildKeys.self)
        try container.encode(self.game, forKey: .game)
    }
    
    func saveGame() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(game)
            try data.write(to: MiniGolfGameManager.dataFilePath!)
        } catch {
            print("Error encoding mini golf game, \(error)")
        }
    }
    
    func loadGame() -> GameManagerProtocol {
        self.game = MiniGolfGame()
        if let data = try? Data(contentsOf: GolfGameManager.dataFilePath!) {
            print("Loading mini golf game")
            self.importData(data: data)
        } else {
            print("Error loading mini golf game")
        }
        return self.game as! GameManagerProtocol
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
            let data = try encoder.encode(self)
            return data
        } catch {
            return nil
        }
    }
    
    func addPlayer(playerName: String) {
        self.game.players.append(Player(playerId: self.game.players.count - 1, name: playerName))
    }
    
    func removePlayer(player: Player) {
        self.game.players.remove(at: player.playerId)
        self.updatePlayerNums()
    }
    
    func updatePlayerNums() {
        for i in 0...self.game.players.count {
            self.game.players[i].playerId = i
        }
    }
    
    func updatePlayerStrokes(playerId: Int, incrementBy val: Int) {
        self.game.players[playerId].holes[self.game.currentHoleIndex].strokesTaken += val
    }
}
