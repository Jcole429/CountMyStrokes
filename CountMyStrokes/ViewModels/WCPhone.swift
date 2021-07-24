//
//  ViewModelPhone.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI
import WatchConnectivity

class WCPhone: NSObject, ObservableObject {
    
    var session: WCSession
    @Published var golfGameManager = GolfGameManager()
    @Published var miniGolfGameManager = MiniGolfGameManager()
    var gameMode: GameMode
    
    init(session: WCSession = .default) {
        self.session = session
        self.gameMode = GameMode.golfMode
        super.init()
        self.loadGameMode()
        self.session.delegate = self
        session.activate()
        self.golfGameManager.loadGame()
        self.miniGolfGameManager.loadGame()
    }
    
    func updateWatch(gameManager: GameManagerProtocol, messageString: String) {
        if session.activationState == .activated {
            if session.isReachable {
                print("Phone - sendMessageData()")
                session.sendMessage([messageString: gameManager.getData()!]) { response in
                    print("Response: \(response)")
                } errorHandler: { error in
                    print("Error \(error)")
                }
            } else {
                do {
                    print("Phone - updateApplicationContext()")
                    try session.updateApplicationContext([messageString: gameManager.getData()!])
                } catch {
                    print("Error sending data to watch: \(error)")
                }
            }
        }
    }
    
    func updateWatchGolf() {
        self.updateWatch(gameManager: self.golfGameManager, messageString: K.gameManagers.golfGameManager)
    }
    
    func updateWatchMiniGolf() {
        self.updateWatch(gameManager: self.miniGolfGameManager, messageString: K.gameManagers.miniGolfGameManager)
    }
    
    func updateWatchGameMode() {
        print("In updateWatchGameMode()")
        if session.activationState == .activated {
            if session.isReachable {
                let encoder = PropertyListEncoder()
                do {
                    print("Trying to encode: \(self.gameMode)")
                    let data = try encoder.encode([self.gameMode])
                    print("Encoded data: \(data)")
                    session.sendMessage([K.userDefaults.gameMode: data]) { response in
                        print("Response: \(response)")
                    } errorHandler: { error in
                        print("Error: \(error)")
                    }
                } catch {
                    print("Could not encode gameMode")
                }
            }
        }
    }
    
    func updateGameMode(gameMode: GameMode) {
        UserDefaults.standard.set(gameMode.rawValue, forKey: K.userDefaults.gameMode)
        self.objectWillChange.send()
        self.gameMode = gameMode
        self.updateWatchGameMode()
    }
    
    func loadGameMode() {
        let rawValue = UserDefaults.standard.integer(forKey: K.userDefaults.gameMode)
        self.objectWillChange.send()
        self.gameMode = GameMode(rawValue: rawValue) ?? .golfMode
        print("Loaded gameMode value: \(self.gameMode)")
    }
}

extension WCPhone: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("phone - activationDidCompleteWith")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("phone - sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("phone - sessionDidBecomeInactive")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            self.objectWillChange.send()
            if message[K.gameManagers.golfGameManager] != nil {
                print("Phone - message contains golfGameManager data")
                self.golfGameManager.importData(data: message[K.gameManagers.golfGameManager] as! Data)
            } else if message[K.gameManagers.miniGolfGameManager] != nil {
                print("Phone - message contains minGolfGameManager")
                self.miniGolfGameManager.importData(data: message[K.gameManagers.miniGolfGameManager] as! Data)
            }
            else if message[K.userDefaults.gameMode] != nil {
                print("Phone - message contains gameMode data")
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
        print("Phone - didReceiveApplicationContext \(applicationContext)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.golfGameManager.importData(data: applicationContext[K.gameManagers.golfGameManager] as! Data)
        }
        
    }
}
