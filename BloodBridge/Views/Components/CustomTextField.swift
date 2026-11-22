//
//  CustomTextField.swift
//  BloodBridge
//
//  Simple reusable text field and secure field with icons.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var icon: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.primaryRed)
                .frame(width: 20)
            
            TextField(title, text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CustomSecureField: View {
    var title: String
    var icon: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.primaryRed)
                .frame(width: 20)
            
            SecureField(title, text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    VStack {
        CustomTextField(title: "Email", icon: "envelope.fill", text: .constant(""))
        CustomSecureField(title: "Password", icon: "lock.fill", text: .constant(""))
    }
    .padding()
}
