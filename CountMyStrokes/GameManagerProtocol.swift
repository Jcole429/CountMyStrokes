//
//  GameManagerProtocol.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/3/21.
//

import Foundation

protocol GameManagerProtocol {
    func saveGame()
    func loadGame() -> GameManagerProtocol
    func importData(data: Data)
    func getData() -> Data?
}
