//
//  EmptyStateView.swift
//  BloodBridge
//
//  Simple reusable empty state display with icon, title, and message.
//

import SwiftUI

struct EmptyStateView: View {
    var icon: String
    var title: String
    var message: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(AppTheme.primaryRed)
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.vertical, 30)
    }
}

#Preview {
    EmptyStateView(
        icon: "magnifyingglass",
        title: "No Results",
        message: "No data available at this time."
    )
}
