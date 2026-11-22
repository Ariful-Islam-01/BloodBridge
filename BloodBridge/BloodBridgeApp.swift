//
//  BloodBridgeApp.swift
//  BloodBridge
//
//  Created by Md Sabbir Hossain on 13/11/26.
//

import SwiftUI
import FirebaseCore

@main
struct BloodBridgeApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
