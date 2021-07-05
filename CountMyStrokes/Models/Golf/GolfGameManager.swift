//
//  GameManager.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import Foundation

class GolfGameManager: GameManagerProtocol, ObservableObject {
    
    static let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("golfGame.plist")
    
    @Published var game = GolfGame()
    
    func getCurrentHole() -> Hole {
        return game.holes[game.currentHoleIndex]
    }
    
    func updateStrokesTaken(holeIndex: Int?, newValue: Int) {
        self.objectWillChange.send()
        if let index = holeIndex {
            game.holes[index].strokesTaken = newValue
        } else {
            game.holes[game.currentHoleIndex].strokesTaken = newValue
        }
    }
    
    func updateChipsTaken(holeIndex: Int?, newValue: Int) {
        if let index = holeIndex {
            game.holes[index].chipsTaken = newValue
        } else {
            game.holes[game.currentHoleIndex].chipsTaken = newValue
        }
    }
    
    func updatePutsTaken(holeIndex: Int?, newValue: Int) {
        if let index = holeIndex {
            game.holes[index].putsTaken = newValue
        } else {
            game.holes[game.currentHoleIndex].putsTaken = newValue
        }
    }
    
    func updatePenaltiesTaken(holeIndex: Int?, newValue: Int) {
        if let index = holeIndex {
            game.holes[index].penaltiesTaken = newValue
        } else {
            game.holes[game.currentHoleIndex].penaltiesTaken = newValue
        }
    }
    
    func incrementCurrentHoleStrokesTaken() {
        updateStrokesTaken(holeIndex: nil, newValue: getCurrentHole().strokesTaken + 1)
    }
    
    func decrementCurrentHoleStrokesTaken() {
        if getCurrentHole().strokesTaken > 0 {
            updateStrokesTaken(holeIndex: nil, newValue: getCurrentHole().strokesTaken - 1)
        }
    }
    
    func incrementCurrentHoleChipsTaken() {
        updateChipsTaken(holeIndex: nil, newValue: getCurrentHole().chipsTaken + 1)
    }
    
    func decrementCurrentHoleChipsTaken() {
        if getCurrentHole().chipsTaken > 0 {
            updateChipsTaken(holeIndex: nil, newValue: getCurrentHole().chipsTaken - 1)
        }
    }
    
    func incrementCurrentHolePutsTaken() {
        updatePutsTaken(holeIndex: nil, newValue: getCurrentHole().putsTaken + 1)
    }
    
    func decrementCurrentHolePutsTaken() {
        if getCurrentHole().putsTaken > 0 {
            updatePutsTaken(holeIndex: nil, newValue: getCurrentHole().putsTaken - 1)
        }
    }
    
    func incrementCurrentHolePenaltiesTaken() {
        updatePenaltiesTaken(holeIndex: nil, newValue: getCurrentHole().penaltiesTaken + 1)
    }
    
    func decrementCurrentHolePenaltiesTaken() {
        if getCurrentHole().penaltiesTaken > 0 {
            updatePenaltiesTaken(holeIndex: nil, newValue: getCurrentHole().penaltiesTaken - 1)
        }
    }
    
    func nextHole() -> Bool {
        if self.game.currentHoleIndex < 17 {
            self.game.currentHoleIndex += 1
            if self.game.holes.count <= self.game.currentHoleIndex {
                self.game.holes.append(Hole(holeNumber: self.game.currentHoleIndex + 1, par: nil))
            }
            return true
        } else {
            return false
        }
    }
    
    func previousHole() -> Bool {
        if self.game.currentHoleIndex > 0 {
            self.game.currentHoleIndex -= 1
            return true
        } else {
            return false
        }
    }
    
    func setGreenInRegulation(result: Bool?) {
        self.game.holes[self.game.currentHoleIndex].greenInRegulation = result
    }
    
    func pressedGreenInRegulation() {
        if self.getCurrentHole().greenInRegulation != true {
            self.setGreenInRegulation(result: true)
        } else if self.getCurrentHole().greenInRegulation == true {
            self.setGreenInRegulation(result: nil)
        }
    }
    
    func pressedGreenNotInRegulation() {
        if self.getCurrentHole().greenInRegulation != false {
            self.setGreenInRegulation(result: false)
        } else if self.getCurrentHole().greenInRegulation == false {
            self.setGreenInRegulation(result: nil)
        }
    }
    
    func saveGame() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.game)
            try data.write(to: GolfGameManager.dataFilePath!)
        } catch {
            print("Error saving golfGame, \(error)")
        }
    }
    
    func loadGame() {
        if let data = try? Data(contentsOf: GolfGameManager.dataFilePath!) {
            print("Loading golfGame")
            self.importData(data: data)
        } else {
            print("Error loading golfGame")
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
    
    func newGame() {
        self.game = GolfGame()
    }
    
    func importData(data: Data) {
        let decoder = PropertyListDecoder()
        do {
            let updatedGame = try decoder.decode(GolfGame.self, from: data)
            self.objectWillChange.send()
            self.game = updatedGame
            print("Imported golfGame data")
        } catch {
            print("Error decoding golfGame, \(error)")
        }
    }
}
