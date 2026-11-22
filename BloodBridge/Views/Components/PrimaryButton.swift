//
//  PrimaryButton.swift
//  BloodBridge
//
//  Simple reusable button with red background and white text.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var icon: String? = nil
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(AppTheme.primaryRed)
            .cornerRadius(10)
        }
    }
}

#Preview {
    PrimaryButton(title: "Log In", icon: "arrow.right") { }
        .padding()
}
