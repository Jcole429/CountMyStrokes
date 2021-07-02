//
//  Player.swift
//  CountMyStrokes
//
//  Created by Justin Cole on 7/2/21.
//

import Foundation

struct Player: Codable {
    var playerId: Int
    var name: String
    var holes: [Hole] = []
    var score: Int {
        get {
            var sum = 0
            for hole in holes {
                sum += hole.totalStrokesTaken
            }
            return sum
        }
    }
}
