//
//  Hole.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import Foundation

class Hole: Codable, ObservableObject {
    @Published var holeNumber: Int
    @Published var par: Int?
    var totalStrokesTaken: Int {
        get {
            return strokesTaken + chipsTaken + putsTaken + penaltiesTaken
        }
    }
    @Published var strokesTaken = 0 {
        willSet {
            print("WillSet strokesTaken")
            objectWillChange.send()
        }
    }
    @Published var chipsTaken = 0
    @Published var putsTaken = 0
    @Published var penaltiesTaken = 0
    @Published var greenInRegulation: Bool? = nil
    
    enum ChildKeys: CodingKey {
        case holeNumber, par, strokesTaken, chipsTaken, putsTaken, penaltiesTaken, greenInRegulation
    }
    
    init(holeNumber: Int, par: Int?) {
        self.holeNumber = holeNumber
        self.par = par
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildKeys.self)
        self.holeNumber = try container.decode(Int.self, forKey: .holeNumber)
        self.par = try container.decodeIfPresent(Int.self, forKey: .par)
        self.strokesTaken = try container.decode(Int.self, forKey: .strokesTaken)
        self.chipsTaken = try container.decode(Int.self, forKey: .chipsTaken)
        self.putsTaken = try container.decode(Int.self, forKey: .putsTaken)
        self.penaltiesTaken = try container.decode(Int.self, forKey: .penaltiesTaken)
        self.greenInRegulation = try container.decodeIfPresent(Bool.self, forKey: .greenInRegulation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildKeys.self)
        try container.encode(self.holeNumber, forKey: .holeNumber)
        try container.encodeIfPresent(self.par, forKey: .par)
        try container.encode(self.strokesTaken, forKey: .strokesTaken)
        try container.encode(self.chipsTaken, forKey: .chipsTaken)
        try container.encode(self.putsTaken, forKey: .putsTaken)
        try container.encode(self.penaltiesTaken, forKey: .penaltiesTaken)
        try container.encode(self.greenInRegulation, forKey: .greenInRegulation)
    }
}
