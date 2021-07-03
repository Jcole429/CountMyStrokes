//
//  ViewModelPhone.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import SwiftUI
import WatchConnectivity

class WatchConnectivityPhone: NSObject, ObservableObject {
    
    var session: WCSession
    @Published var gameManager = GolfGameManager().loadGame() as! GolfGameManager
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func updateWatch() {
        if session.activationState == .activated {
            if session.isReachable {
                print("Phone - sendMessageData()")
                session.sendMessageData(gameManager.getData()!) { response in
                    print("Response: \(response)")
                } errorHandler: { error in
                    print("Error \(error)")
                }
            } else {
                do {
                    print("Phone - updateApplicationContext()")
                    try session.updateApplicationContext(["gameManager": gameManager.getData()!])
                } catch {
                    print("Error sending data to watch: \(error)")
                }
            }
        }
    }
}

extension WatchConnectivityPhone: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("phone - activationDidCompleteWith")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("phone - sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("phone - sessionDidBecomeInactive")
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        print("Phone - didReceiveMessageData \(messageData)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.gameManager.importData(data: messageData)
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Phone - didReceiveApplicationContext \(applicationContext)")
        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.gameManager.importData(data: applicationContext["gameManager"] as! Data)
        }
        
    }
}
