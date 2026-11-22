//
//  FindDonorsView.swift
//  BloodBridge
//
//  Search and filter screen for blood donors connected to Cloud Firestore.
//

import SwiftUI

struct FindDonorsView: View {
    @StateObject private var viewModel = FindDonorsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Search Input Card
                VStack(spacing: 12) {
                    CustomTextField(
                        title: "Search by donor name, city, or area...",
                        icon: "magnifyingglass",
                        text: $viewModel.searchText
                    )
                    
                    // Blood Group Filter Picker
                    HStack {
                        Text("Blood Group:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Picker("Blood Group", selection: $viewModel.selectedBloodGroup) {
                            Text("All Blood Groups").tag("All")
                            ForEach(BloodGroup.allCases) { group in
                                Text(group.rawValue).tag(group.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(AppTheme.primaryRed)
                    }
                    .padding(.horizontal, 4)
                }
                .padding()
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Loading State
                if viewModel.isLoading {
                    ProgressView("Searching donors...")
                        .padding(.vertical, 30)
                }
                
                // Error State
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Results List or Empty State
                if !viewModel.isLoading && viewModel.errorMessage.isEmpty {
                    if viewModel.filteredDonors.isEmpty {
                        EmptyStateView(
                            icon: "person.2.slash",
                            title: "No Donors Found",
                            message: "No donors found matching your search. Try changing the blood group filter or location."
                        )
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(viewModel.filteredDonors) { donor in
                                DonorCard(donor: donor)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.bottom, 24)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Find Donors")
        .onAppear {
            viewModel.fetchDonors()
        }
        .refreshable {
            viewModel.fetchDonors()
        }
    }
}

// MARK: - Donor Card View Component
struct DonorCard: View {
    let donor: DonorProfile
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                // Blood Group Badge
                Text(donor.bloodGroup)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(AppTheme.primaryRed)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(donor.fullName)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(donor.area), \(donor.city)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                // Availability Status Badge
                HStack(spacing: 4) {
                    Circle()
                        .fill(donor.isAvailable ? Color.green : Color.gray)
                        .frame(width: 8, height: 8)
                    Text(donor.isAvailable ? "Available" : "Unavailable")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(donor.isAvailable ? .green : .gray)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(donor.isAvailable ? Color.green.opacity(0.12) : Color.gray.opacity(0.12))
                .cornerRadius(6)
            }
            
            Divider()
            
            // Phone Contact Detail
            HStack {
                Image(systemName: "phone.fill")
                    .font(.caption)
                    .foregroundColor(AppTheme.primaryRed)
                Text(donor.phone.isEmpty ? "No phone provided" : donor.phone)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        FindDonorsView()
    }
}
