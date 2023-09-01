//
//  LoadingView.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 25/08/23.
//

import SwiftUI

struct LoadingView: View {
    
    let loadingState : LoadingState

    var body: some View {
        switch loadingState {
        case .idle, .success, .failure:
            EmptyView()
        case .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: 100)
                .scaleEffect(1.5, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                .foregroundColor(.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .padding()
        }
    }
}
