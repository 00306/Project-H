//
//  MainView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/12/24.
//

import SwiftUI

struct MainView: View {
    let authService: AuthService
    
    init(authService: AuthService = AuthManager.shared) {
        self.authService = authService
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button("로그아웃") {
            authService.signOut()
        }
    }
}

#Preview {
    MainView()
}
