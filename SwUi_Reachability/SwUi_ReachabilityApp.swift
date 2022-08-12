//
//  SwUi_ReachabilityApp.swift
//  SwUi_Reachability
//
//  Created by Marcelo Sampaio on 10/08/22.
//

import SwiftUI

@main
struct SwUi_ReachabilityApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
        .onChange(of: scenePhase) { (phase) in
            switch phase {
            case .active:
                print("✅ ScenePhase: Active")
                Reachability.standard.isActive = true
            case .background:
                print("🧮 ScenePhase: Background")
                Reachability.standard.isActive = false
            case .inactive:
                print("ScenePhase: inactive entering \(Reachability.standard.isActive ? "🧮 background" : "✅ foreground")")
            @unknown default: print("❌ ScenePhase: unexpected state")
            }
        }
    }
}
