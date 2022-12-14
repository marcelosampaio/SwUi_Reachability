//
//  Reachability.swift
//  SwUi_Reachability
//
//  Created by Marcelo Sampaio on 10/08/22.
//

import SwiftUI
import Network

struct Constants {
    static let reachabilityChanged = "reachabilityChanged"
    static let connected = "isConnected"
}

class Reachability: ObservableObject {
    static let standard = Reachability()
    var isActive = false
    let monitor = NWPathMonitor()
    let notification = NotificationCenter.default

    class var shared: Reachability {
        return standard
    }

    private init() {
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("👍 connected to the internet")
                self.notification.post(name: Notification.Name(Constants.reachabilityChanged),
                                       object: nil,
                                       userInfo: [Constants.connected: true])
            } else {
                print("❌ No internet connection")
                self.notification.post(name: Notification.Name(Constants.reachabilityChanged), object: nil, userInfo: ["isConnected": false])
            }
        }
    }

    func startMonitoring() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
