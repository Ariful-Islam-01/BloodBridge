//
//  DonationHistoryView.swift
//  BloodBridge
//
//  Screen showing donor donation records and impact metrics.
//

import SwiftUI

struct DonationHistoryView: View {
    // Sample UI-only records
    @State private var records: [DonationRecord] = [
        DonationRecord(
            donationDate: "October 14, 2026",
            hospitalOrBloodBank: "Red Crescent Blood Center",
            city: "Dhaka",
            unitsDonated: 1,
            notes: "Routine voluntary donation."
        ),
        DonationRecord(
            donationDate: "June 20, 2026",
            hospitalOrBloodBank: "Dhaka Medical College Hospital",
            city: "Dhaka",
            unitsDonated: 1,
            notes: "Emergency call response for patient."
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Summary Stats Card
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Donations")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("\(records.count)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primaryRed)
                    }
                    
                    Divider()
                        .frame(height: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Lives Saved (Est.)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("\(records.count * 3)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Past Donations Section
                HStack {
                    Text("Past Donations")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                if records.isEmpty {
                    EmptyStateView(
                        icon: "clock.arrow.circlepath",
                        title: "No Donation History",
                        message: "Your completed donations will appear here."
                    )
                    .padding(.horizontal)
                } else {
                    VStack(spacing: 10) {
                        ForEach(records) { record in
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(record.donationDate)
                                        .font(.headline)
                                    Spacer()
                                    Text("\(record.unitsDonated) Unit")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(AppTheme.primaryRed)
                                }
                                
                                Text("\(record.hospitalOrBloodBank), \(record.city)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                if !record.notes.isEmpty {
                                    Text(record.notes)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(AppTheme.cardBackground)
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Donation History")
    }
}

#Preview {
    NavigationStack {
        DonationHistoryView()
    }
}
