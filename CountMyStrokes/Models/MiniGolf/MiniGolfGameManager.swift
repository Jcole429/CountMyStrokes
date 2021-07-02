//
//  MiniGolfGameManager.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import Foundation

class MiniGolfGameManager: ObservableObject {
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("MiniGolfGame.plist")
    
    @Published var game = MiniGolfGame()
    
    func saveGame() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(game)
            try data.write(to: MiniGolfGameManager.dataFilePath!)
        } catch {
            print("Error encoding mini golf game, \(error)")
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
    
    func loadGame() {
        self.game = MiniGolfGame()
        if let data = try? Data(contentsOf: GameManager.dataFilePath!) {
            print("Loading mini golf game")
            self.importData(data: data)
        } else {
            print("Error loading mini golf game")
        }
    }
}
