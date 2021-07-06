//
//  File.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI
import WatchConnectivity

class ViewModelWatch: NSObject, ObservableObject {
    
    var session: WCSession
    @Published var golfGameManager = GolfGameManager()
    
    var golfGameManagerString = "golfGameManager"
    init(session: WCSession = .default) {
        self.session = session
        super.init()
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
        self.updatePhone(gameManager: self.golfGameManager, messageString: self.golfGameManagerString)
    }
}

extension ViewModelWatch: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch - activationDidCompleteWith")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("Watch - didReceiveMessage: \(message)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.golfGameManager.importData(data: message[self.golfGameManagerString] as! Data)
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Watch - didReceiveApplicationContext: \(applicationContext)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.golfGameManager.importData(data: applicationContext[self.golfGameManagerString] as! Data)
        }
    }
}
