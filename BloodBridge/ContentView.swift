//
//  ContentView.swift
//  BloodBridge
//
//  Root coordinator view that switches between Login and Home Dashboard.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isLoggedIn {
                NavigationStack {
                    HomeView()
                }
            } else {
                NavigationStack {
                    LoginView()
                }
            }
        }
        .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}
