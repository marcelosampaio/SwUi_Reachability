//
//  ContentView.swift
//  SwUi_Reachability
//
//  Created by Marcelo Sampaio on 10/08/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .connected:
                VStack {
                    Text("👍 Connected to the internet")
                    Button("Go to detail view") {
                        viewModel.showDetail()
                    }
                }
                
                
            case .disconnected:
                Text("❌ Disconnected")
            case .detail:
                viewModel.detailView()
            }
        }
        .task {
            viewModel.internetConnection()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
