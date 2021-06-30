//
//  File.swift
//  CountMyStrokes2 WatchKit Extension
//
//  Created by Justin Cole on 6/29/21.
//

import Foundation
import WatchConnectivity

class ViewModelWatch: NSObject, ObservableObject {
    
    var session: WCSession
    
    @Published var testString = "No bueno"
    @Published var messageText = ""
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
}

extension ViewModelWatch: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Watch - activationDidCompleteWith()")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("Watch - didReceiveApplicationContext")
        testString = applicationContext["gameManager"] as! String
        print("Received: \(testString)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.messageText = message["message"] as? String ?? "Unknown"
        }
    }
}
