//
//  File.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI
import WatchConnectivity

class WCWatch: NSObject, ObservableObject {
    
    var session: WCSession
    @Published var golfGameManager = GolfGameManager()
    @Published var gameMode: GameMode
    
    init(session: WCSession = .default) {
        self.session = session
        self.gameMode = GameMode.golfMode
        super.init()
        self.loadGameMode()
        self.session.delegate = self
        session.activate()
    }
    
    func updatePhone(gameManager: GameManagerProtocol, messageString: String) {
        if session.activationState == .activated {
            print("Watch - updatePhone()")
            if session.isReachable {
                session.sendMessage([messageString : gameManager.getData()!])  { response in
                    print("Response: \(response)")
                } errorHandler: { error in
                    print("Error sending data to phone: \(error)")
                }
            } else {
                do {
                    print("Watch - updateApplicationContext()")
                    try session.updateApplicationContext([messageString: gameManager.getData()!])
                } catch {
                    print("Error sending data to phone: \(error)")
                }
            }
        }
    }
    
    func updatePhoneGolf() {
        self.updatePhone(gameManager: self.golfGameManager, messageString: K.gameManagers.golfGameManager)
    }
    
    func updateGameMode(gameMode: GameMode) {
        UserDefaults.standard.set(gameMode.rawValue, forKey: K.userDefaults.gameMode)
        self.objectWillChange.send()
        self.gameMode = gameMode
    }
    
    func loadGameMode() {
        let rawValue = UserDefaults.standard.integer(forKey: K.userDefaults.gameMode)
        self.objectWillChange.send()
        self.gameMode = GameMode(rawValue: rawValue) ?? .golfMode
        print("Loaded gameMode value: \(self.gameMode)")
    }
}

extension WCWatch: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch - activationDidCompleteWith")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("Watch - didReceiveMessage: \(message)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            if message[K.gameManagers.golfGameManager] != nil {
                print("Watch - message contains golfGameManager data")
                self.golfGameManager.importData(data: message[K.gameManagers.golfGameManager] as! Data)
            } else if message[K.userDefaults.gameMode] != nil {
                print("Watch - message contains gameMode data")
                let decoder = PropertyListDecoder()
                do {
                    let decodedGameMode = try decoder.decode([GameMode].self, from: message[K.userDefaults.gameMode] as! Data)
                    self.updateGameMode(gameMode: decodedGameMode[0])
                }
                catch {
                    print("Could not decode gameMode")
                }
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Watch - didReceiveApplicationContext: \(applicationContext)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.golfGameManager.importData(data: applicationContext[K.gameManagers.golfGameManager] as! Data)
        }
    }
}
