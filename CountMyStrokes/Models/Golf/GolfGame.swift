//
//  Game.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import Foundation

struct GolfGame: Codable {
    var holes: [Hole] = [Hole(holeNumber: 1, par: nil)]
    var totalScore: Int {
        get {
            var sum = 0
            for hole in holes {
                sum += hole.totalStrokesTaken
            }
            return sum
        }
    }
}
