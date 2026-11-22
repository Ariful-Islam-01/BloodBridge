//
//  BloodCompatibilityView.swift
//  BloodBridge
//
//  Educational screen for blood group compatibility information.
//

import SwiftUI

struct BloodCompatibilityView: View {
    @StateObject private var viewModel = BloodCompatibilityViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Educational & Medical Disclaimer Banner
                disclaimerBanner
                
                if !viewModel.errorMessage.isEmpty {
                    EmptyStateView(
                        icon: "exclamationmark.triangle",
                        title: "Unable to Load Data",
                        message: viewModel.errorMessage
                    )
                    .padding()
                } else if viewModel.bloodGroupsInfo.isEmpty {
                    ProgressView("Loading information...")
                        .padding(.vertical, 30)
                } else {
                    // Blood Group Selector Chips
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.bloodGroupsInfo) { info in
                                Button(action: {
                                    viewModel.selectedGroup = info.bloodGroup
                                }) {
                                    Text(info.bloodGroup)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(viewModel.selectedGroup == info.bloodGroup ? .white : AppTheme.primaryRed)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(viewModel.selectedGroup == info.bloodGroup ? AppTheme.primaryRed : Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 4)
                    
                    // Selected Group Compatibility Details Card
                    if let selected = viewModel.selectedInfo {
                        compatibilityDetailCard(for: selected)
                    }
                    
                    // Full Reference List Header
                    HStack {
                        Text("All Blood Groups Reference")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // All Groups Reference Cards
                    VStack(spacing: 12) {
                        ForEach(viewModel.bloodGroupsInfo) { info in
                            BloodGroupRow(info: info)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 24)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Blood Compatibility")
    }
    
    // MARK: - Disclaimer Banner
    private var disclaimerBanner: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "cross.case.fill")
                .font(.title2)
                .foregroundColor(AppTheme.primaryRed)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Educational Information Only")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.primaryRed)
                
                Text("This chart applies specifically to Red Blood Cell (RBC) transfusions. Real clinical blood transfusions always require professional laboratory testing, Rh typing, and antibody crossmatching.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(12)
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    // MARK: - Compatibility Card for Selected Group
    private func compatibilityDetailCard(for info: BloodGroupInfo) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(info.bloodGroup)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(AppTheme.primaryRed)
                    .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Blood Group \(info.bloodGroup)")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("Red Blood Cell (RBC) Profile")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Text(info.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            // Can Donate To
            VStack(alignment: .leading, spacing: 6) {
                Text("Can Donate Red Blood Cells To:")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                FlowTags(items: info.canDonateTo, color: .green)
            }
            
            // Can Receive From
            VStack(alignment: .leading, spacing: 6) {
                Text("Can Receive Red Blood Cells From:")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                FlowTags(items: info.canReceiveFrom, color: .blue)
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// Simple tag row for compatible groups
struct FlowTags: View {
    let items: [String]
    let color: Color
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(color.opacity(0.12))
                    .cornerRadius(6)
            }
        }
    }
}

// Simple row for reference list
struct BloodGroupRow: View {
    let info: BloodGroupInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(info.bloodGroup)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(AppTheme.primaryRed)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Group \(info.bloodGroup)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    Text("Gives to: \(info.canDonateTo.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("Receives: \(info.canReceiveFrom.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(10)
    }
}

#Preview {
    NavigationStack {
        BloodCompatibilityView()
    }
}

