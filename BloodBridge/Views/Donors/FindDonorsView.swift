//
//  FindDonorsView.swift
//  BloodBridge
//
//  Search screen for blood donors using simple SwiftUI components.
//

import SwiftUI

struct FindDonorsView: View {
    @State private var selectedBloodGroup: String = ""
    @State private var searchCity: String = ""
    @State private var hasSearched: Bool = false
    
    // List of blood groups for selection
    let bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Instructions
                VStack(alignment: .leading, spacing: 4) {
                    Text("Select Blood Group")
                        .font(.headline)
                    Text("Tap a blood group to filter prospective donors.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Blood Group Buttons
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 10) {
                    ForEach(bloodGroups, id: \.self) { group in
                        Button(action: {
                            if selectedBloodGroup == group {
                                selectedBloodGroup = ""
                            } else {
                                selectedBloodGroup = group
                            }
                        }) {
                            Text(group)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(selectedBloodGroup == group ? .white : AppTheme.primaryRed)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(selectedBloodGroup == group ? AppTheme.primaryRed : Color(.systemGray6))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Search Field & Button
                VStack(spacing: 12) {
                    CustomTextField(
                        title: "Enter City or Area (e.g. Dhaka)",
                        icon: "magnifyingglass",
                        text: $searchCity
                    )
                    
                    PrimaryButton(title: "Search Donors", icon: "magnifyingglass") {
                        hasSearched = true
                    }
                }
                .padding()
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Empty state results
                if hasSearched {
                    EmptyStateView(
                        icon: "person.2.slash",
                        title: "No Donors Found",
                        message: "No donors found for \(selectedBloodGroup.isEmpty ? "All Groups" : selectedBloodGroup) in \"\(searchCity.isEmpty ? "All Areas" : searchCity)\". Real database connection will be added in Phase 4."
                    )
                    .padding(.horizontal)
                } else {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "Search For Donors",
                        message: "Select a blood group and enter a location to begin searching."
                    )
                    .padding(.horizontal)
                }
            }
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Find Donors")
    }
}

#Preview {
    NavigationStack {
        FindDonorsView()
    }
}
