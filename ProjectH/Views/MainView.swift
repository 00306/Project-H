//
//  MainView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/12/24.
//

import SwiftUI

struct MainView: View {
    let authService: AuthService
    let mainViewModel = MainViewModel()
    
    init(authService: AuthService = AuthManager.shared) {
        self.authService = authService
    }
    
    var body: some View {
        VStack {
            ForEach(mainViewModel.hackathons, id: \.self) { hackathon in
                Text(hackathon.id!)
                Text(hackathon.name)
                Text(hackathon.description)
            }
            
            Button("파이어스토어") {
                mainViewModel.fetchHackathons()
            }
            
            Button("로그아웃") {
                authService.signOut()
            }
        }
    }
}

#Preview {
    MainView()
}
