//
//  ProjectHApp.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import FirebaseCore
import SwiftUI

@main
struct ProjectHApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
