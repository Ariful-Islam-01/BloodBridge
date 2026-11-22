//
//  DonorProfileView.swift
//  BloodBridge
//
//  Donor Profile screen using a simple SwiftUI Form.
//

import SwiftUI

struct DonorProfileView: View {
    @State private var fullName: String = "Md Sabbir Hossain"
    @State private var selectedBloodGroup: String = "O+"
    @State private var phone: String = "+880 1700 000000"
    @State private var city: String = "Dhaka"
    @State private var area: String = "Dhanmondi"
    @State private var isAvailable: Bool = true
    @State private var showSavedAlert: Bool = false
    
    let bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Full Name", text: $fullName)
                
                Picker("Blood Group", selection: $selectedBloodGroup) {
                    ForEach(bloodGroups, id: \.self) { group in
                        Text(group).tag(group)
                    }
                }
                
                TextField("Phone Number", text: $phone)
                TextField("City", text: $city)
                TextField("Area", text: $area)
            }
            
            Section(header: Text("Donor Availability")) {
                Toggle("Available to Donate Blood", isOn: $isAvailable)
            }
            
            Section {
                Button(action: {
                    showSavedAlert = true
                }) {
                    HStack {
                        Spacer()
                        Text("Save Profile Changes")
                            .fontWeight(.bold)
                            .foregroundColor(AppTheme.primaryRed)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("My Donor Profile")
        .alert("Profile Updated", isPresented: $showSavedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your profile information has been saved (UI only).")
        }
    }
}

#Preview {
    NavigationStack {
        DonorProfileView()
    }
}
