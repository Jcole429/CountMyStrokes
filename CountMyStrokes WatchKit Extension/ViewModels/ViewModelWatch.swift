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
    @Published var gameManager = GolfGameManager()
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func updatePhone() {
        if session.activationState == .activated {
            print("Watch - updatePhone()")
            if session.isReachable {
                WCSession.default.sendMessageData(gameManager.getData()!) { response in
                    print("Response: \(response)")
                } errorHandler: { error in
                    print("Error sending data to phone: \(error)")
                }
            } else {
                do {
                    print("Watch - updateApplicationContext()")
                    try WCSession.default.updateApplicationContext(["gameManager": gameManager.getData()!])
                } catch {
                    print("Error sending data to phone: \(error)")
                }
            }
        }
    }
}

extension ViewModelWatch: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch - activationDidCompleteWith")
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        print("Watch - didReceiveMessageData: \(messageData)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.gameManager.importData(data: messageData)
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Watch - didReceiveApplicationContext: \(applicationContext)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.gameManager.importData(data: applicationContext["gameManager"] as! Data)
        }
    }
}
