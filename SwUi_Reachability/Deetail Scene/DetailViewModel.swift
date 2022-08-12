//
//  DetailViewModel.swift
//  SwUi_Reachability
//
//  Created by Marcelo Sampaio on 11/08/22.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var uiState: DetailUIState = .ready
    private var notificationCenter = NotificationCenter.default
    
    init() {
        observers()
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
                self.uiState = .ready
            }
        } else {
            DispatchQueue.main.async {
                self.uiState = .disconnected
            }
        }
    }
}

extension DetailViewModel {
    func contentView() -> some View {
        return ContentView(viewModel: ContentViewModel())
    }
}

extension DetailViewModel {
    func back() {
        self.uiState = .back
    }
}
