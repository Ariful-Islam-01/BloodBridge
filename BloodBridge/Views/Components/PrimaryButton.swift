//
//  PrimaryButton.swift
//  BloodBridge
//
//  Simple reusable button with red background, white text, and loading state.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var icon: String? = nil
    var isLoading: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                    }
                    Text(title)
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(AppTheme.primaryRed)
            .cornerRadius(10)
        }
        .disabled(isLoading)
    }
}

#Preview {
    VStack(spacing: 16) {
        PrimaryButton(title: "Log In", icon: "arrow.right") { }
        PrimaryButton(title: "Loading...", isLoading: true) { }
    }
    .padding()
}
