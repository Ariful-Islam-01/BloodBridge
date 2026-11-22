//
//  HomeView.swift
//  BloodBridge
//
//  Home Dashboard with simple navigation to all main features.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Welcome Banner
                VStack(alignment: .leading, spacing: 6) {
                    Text(authViewModel.userDisplayName.isEmpty ? "Welcome to BloodBridge 👋" : "Welcome, \(authViewModel.userDisplayName) 👋")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Every blood donation can save up to three lives.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Section Title
                HStack {
                    Text("Dashboard Actions")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                // 1. Find Donors
                NavigationLink(destination: FindDonorsView()) {
                    HomeCard(
                        title: "Find Donors",
                        subtitle: "Search available donors by blood group and city",
                        icon: "magnifyingglass",
                        iconColor: .red
                    )
                }
                .padding(.horizontal)
                
                // 2. Donation Requests
                NavigationLink(destination: DonationRequestsView()) {
                    HomeCard(
                        title: "Donation Requests",
                        subtitle: "View urgent blood requests from patients and hospitals",
                        icon: "cross.fill",
                        iconColor: .orange
                    )
                }
                .padding(.horizontal)
                
                // 3. My Donor Profile
                NavigationLink(destination: DonorProfileView()) {
                    HomeCard(
                        title: "My Donor Profile",
                        subtitle: "Update your donor information and availability",
                        icon: "person.fill",
                        iconColor: .blue
                    )
                }
                .padding(.horizontal)
                
                // 4. Donation History
                NavigationLink(destination: DonationHistoryView()) {
                    HomeCard(
                        title: "Donation History",
                        subtitle: "Check your past blood donations and impact",
                        icon: "clock.fill",
                        iconColor: .green
                    )
                }
                .padding(.horizontal)
                
                // 5. Blood Compatibility & Information
                NavigationLink(destination: BloodCompatibilityView()) {
                    HomeCard(
                        title: "Blood Compatibility",
                        subtitle: "Educational chart for red blood cell donor & recipient compatibility",
                        icon: "cross.case.fill",
                        iconColor: .pink
                    )
                }
                .padding(.horizontal)
                
                // 6. Profile & Settings
                NavigationLink(destination: SettingsView()) {
                    HomeCard(
                        title: "Settings",
                        subtitle: "Manage app settings, alerts, and account",
                        icon: "gearshape.fill",
                        iconColor: .purple
                    )
                }
                .padding(.horizontal)
                
                // Logout Button
                Button(action: {
                    authViewModel.logout()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Log Out")
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.cardBackground)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("BloodBridge")
    }
}

// Simple helper view for dashboard cards
struct HomeCard: View {
    var title: String
    var subtitle: String
    var icon: String
    var iconColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(iconColor)
                .frame(width: 40, height: 40)
                .background(iconColor.opacity(0.15))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}
