//
//  BloodBridgeLogoView.swift
//  BloodBridge
//
//  Simple reusable logo component with BloodBridge title and tagline.
//

import SwiftUI

struct BloodBridgeLogoView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "drop.fill")
                .font(.system(size: 50))
                .foregroundColor(AppTheme.primaryRed)
            
            Text("BloodBridge")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Connecting Donors • Saving Lives")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    BloodBridgeLogoView()
}
