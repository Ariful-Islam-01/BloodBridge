//
//  DonorProfileView.swift
//  BloodBridge
//
//  Donor Profile screen integrated with Firebase Firestore.
//

import SwiftUI

struct DonorProfileView: View {
    @StateObject private var viewModel = DonorProfileViewModel()
    
    var body: some View {
        Form {
            // Personal Information Section
            Section(header: Text("Personal Information")) {
                TextField("Full Name", text: $viewModel.fullName)
                    .disabled(viewModel.isLoading)
                
                Picker("Blood Group", selection: $viewModel.selectedBloodGroup) {
                    ForEach(BloodGroup.allCases) { group in
                        Text(group.rawValue).tag(group.rawValue)
                    }
                }
                .disabled(viewModel.isLoading)
                
                TextField("Phone Number", text: $viewModel.phone)
                    .disabled(viewModel.isLoading)
                
                TextField("City (e.g. Dhaka)", text: $viewModel.city)
                    .disabled(viewModel.isLoading)
                
                TextField("Area / Neighborhood", text: $viewModel.area)
                    .disabled(viewModel.isLoading)
            }
            
            // Availability Section
            Section(header: Text("Donor Availability")) {
                Toggle("Available to Donate Blood", isOn: $viewModel.isAvailable)
                    .disabled(viewModel.isLoading)
            }
            
            // Status Feedback Section
            if !viewModel.errorMessage.isEmpty {
                Section {
                    Text(viewModel.errorMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
            
            if !viewModel.successMessage.isEmpty {
                Section {
                    Text(viewModel.successMessage)
                        .font(.footnote)
                        .foregroundColor(.green)
                }
            }
            
            // Save Button Section
            Section {
                Button(action: {
                    viewModel.saveProfile()
                }) {
                    HStack {
                        Spacer()
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.primaryRed))
                        } else {
                            Text("Save Profile Changes")
                                .fontWeight(.bold)
                                .foregroundColor(AppTheme.primaryRed)
                        }
                        Spacer()
                    }
                }
                .disabled(viewModel.isLoading)
            }
        }
        .navigationTitle("My Donor Profile")
        .onAppear {
            viewModel.fetchProfile()
        }
    }
}

#Preview {
    NavigationStack {
        DonorProfileView()
    }
}
