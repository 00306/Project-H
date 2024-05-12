//
//  ContentView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import SwiftUI

struct ContentView: View {
    let authService: AuthService
        
        init(authService: AuthService = AuthManager.shared) {
            self.authService = authService
        }
    
    var body: some View {
        Group {
            if authService.authenticationState == .authenticated {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
