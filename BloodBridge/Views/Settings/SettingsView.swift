//
//  SettingsView.swift
//  BloodBridge
//
//  Settings and profile preferences screen using simple SwiftUI List.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var notificationsEnabled: Bool = true
    @State private var locationAlertsEnabled: Bool = true
    @State private var showAboutAlert: Bool = false
    
    var body: some View {
        List {
            // Profile Info Section
            Section(header: Text("Profile")) {
                HStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(AppTheme.primaryRed)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Md Sabbir Hossain")
                            .font(.headline)
                        Text("Blood Group: O+ (Donor)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
            
            // Preferences Section
            Section(header: Text("Notification Preferences")) {
                Toggle("Push Notifications", isOn: $notificationsEnabled)
                Toggle("Nearby Emergency Alerts", isOn: $locationAlertsEnabled)
            }
            
            // About App Section
            Section(header: Text("About")) {
                HStack {
                    Text("App Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.gray)
                }
                
                Button("About BloodBridge") {
                    showAboutAlert = true
                }
            }
            
            // Log Out Section
            Section {
                Button(role: .destructive, action: {
                    authViewModel.logout()
                }) {
                    HStack {
                        Spacer()
                        Text("Log Out")
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .alert("About BloodBridge", isPresented: $showAboutAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("BloodBridge is an iOS application designed to connect voluntary blood donors with patients in urgent need.")
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
