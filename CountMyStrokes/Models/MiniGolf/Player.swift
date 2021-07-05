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
    var holes: [Hole] = [Hole(holeNumber: 0), Hole(holeNumber: 1), Hole(holeNumber: 2), Hole(holeNumber: 3), Hole(holeNumber: 4), Hole(holeNumber: 5), Hole(holeNumber: 6), Hole(holeNumber: 7), Hole(holeNumber: 8), Hole(holeNumber: 9), Hole(holeNumber: 10), Hole(holeNumber: 11), Hole(holeNumber: 12), Hole(holeNumber: 13), Hole(holeNumber: 14), Hole(holeNumber: 15), Hole(holeNumber: 16), Hole(holeNumber: 17)]
    
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
