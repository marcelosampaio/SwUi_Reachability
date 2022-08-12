//
//  DetailView.swift
//  SwUi_Reachability
//
//  Created by Marcelo Sampaio on 11/08/22.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .ready:
                VStack {
                    Text("👍 DetailView is connected")
                    
                    Button("Back") {
                        viewModel.back()
                    }
                }
            case .disconnected:
                Text("❌ DetailView is disconnected")
            case .back:
                viewModel.contentView()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel())
    }
}
