//
//  Game.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import Foundation
import Combine

class Game: Codable, ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    var totalScore: Int {
        get {
            var sum = 0
            for hole in holes {
                sum += hole.totalStrokesTaken
            }
            return sum
        }
    }
    
    var holes: [Hole] {
        willSet {
            print("WillSet holes")
            objectWillChange.send()
        }
        didSet {
            print("Game.holes - didChange.send()")
            didChange.send()
        }
    }
    
    enum ChildKeys: CodingKey {
        case holes
    }
    
    
    init(holes: [Hole]) {
        self.holes = holes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildKeys.self)
        self.holes = try container.decode([Hole].self, forKey: .holes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildKeys.self)
        try container.encode(self.holes, forKey: .holes)
    }
}
