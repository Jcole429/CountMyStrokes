//
//  ViewModelPhone.swift
//  CountMyStrokes2
//
//  Created by Justin Cole on 6/29/21.
//

import Foundation
import WatchConnectivity

class ViewModelPhone: NSObject {
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func updateWatch() {
        do {
            print("Phone - updateApplicationContext()")
            try WCSession.default.updateApplicationContext(["gameManager": "can you hear me?"])
        } catch {
            print("Error sending data to watch: \(error)")
        }
    }
}

extension ViewModelPhone: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("phone - activationDidCompleteWith()")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("phone - sessionDidBecomeInactive()")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("phone - sessionDidDeactivate()")
    }
    
    
}
