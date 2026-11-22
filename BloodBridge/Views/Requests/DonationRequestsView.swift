//
//  DonationRequestsView.swift
//  BloodBridge
//
//  Donation requests screen showing a simple list with empty states.
//

import SwiftUI

struct DonationRequestsView: View {
    @State private var selectedFilter: Int = 0 // 0: All, 1: Urgent
    
    // Sample placeholder data for UI demonstration
    let sampleRequests = [
        DonationRequest(
            patientName: "Emergency Patient",
            bloodGroup: .oNegative,
            hospital: "Dhaka Medical College Hospital",
            city: "Dhaka",
            area: "Bakshibazar",
            unitsNeeded: 2,
            isUrgent: true,
            contactPhone: "+880 1711 000000",
            requiredDate: "Today"
        ),
        DonationRequest(
            patientName: "Surgery Patient",
            bloodGroup: .aPositive,
            hospital: "Square Hospital",
            city: "Dhaka",
            area: "Panthapath",
            unitsNeeded: 1,
            isUrgent: false,
            contactPhone: "+880 1812 000000",
            requiredDate: "Tomorrow"
        )
    ]
    
    var filteredRequests: [DonationRequest] {
        if selectedFilter == 1 {
            return sampleRequests.filter { $0.isUrgent }
        }
        return sampleRequests
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Segmented picker to filter requests
            Picker("Filter", selection: $selectedFilter) {
                Text("All Requests").tag(0)
                Text("Urgent Only").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            // List of requests or empty state
            if filteredRequests.isEmpty {
                EmptyStateView(
                    icon: "tray",
                    title: "No Requests",
                    message: "There are no requests matching this filter."
                )
                Spacer()
            } else {
                List(filteredRequests) { request in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(request.bloodGroup.rawValue)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(AppTheme.primaryRed)
                                .cornerRadius(6)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(request.patientName)
                                    .font(.headline)
                                Text(request.hospital)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            if request.isUrgent {
                                Text("URGENT")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.red)
                                    .cornerRadius(4)
                            }
                        }
                        
                        Text("Location: \(request.area), \(request.city)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("Units Needed: \(request.unitsNeeded) | Date: \(request.requiredDate)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Donation Requests")
    }
}

#Preview {
    NavigationStack {
        DonationRequestsView()
    }
}
