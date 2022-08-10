//
//  ContentViewModel.swift
//  SwUi_Reachability
//
//  Created by Marcelo Sampaio on 10/08/22.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var uiState: ContentUIState = .connected
    private var notificationCenter = NotificationCenter.default
    
    init() {
        observers()
        internetConnection()
    }

    deinit {
        notificationCenter.removeObserver(Notification.Name("reachabilityChanged"))
    }
    
    private func observers() {
        notificationCenter.addObserver(self, selector: #selector(reachabilityChanged), name: Notification.Name("reachabilityChanged"), object: nil)
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        let isConnected = notification.userInfo?["isConnected"] as! Bool
        if isConnected {
            DispatchQueue.main.async {
                self.uiState = .connected
            }
        } else {
            DispatchQueue.main.async {
                self.uiState = .disconnected
            }
        }
    }

    func internetConnection() {
        Reachability.standard.startMonitoring()
    }
}
