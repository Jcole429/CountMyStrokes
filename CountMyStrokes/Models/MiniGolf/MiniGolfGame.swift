//
//  MiniGolfManager.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import Foundation

struct MiniGolfGame: Codable {
    
    var players: [Player]
    var currentHoleIndex = 0
    
    init() {
        self.players = []
    }
    
}
