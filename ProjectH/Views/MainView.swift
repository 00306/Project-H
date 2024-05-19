//
//  MainView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/12/24.
//

import SwiftUI

struct MainView: View {
    let authService: AuthService
    @StateObject var mainViewModel = MainViewModel()
    
    init(authService: AuthService = AuthManager.shared) {
        self.authService = authService
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                hackathonlist
                
                Button("파이어스토어") {
                    mainViewModel.fetchHackathons()
                }
                
                Button("로그아웃") {
                    authService.signOut()
                }
            }
        }
    }
    
    private var hackathonlist: some View {
        ForEach($mainViewModel.hackathons) { $hackathon in
            NavigationLink {
                HackathonDetailView(hackathon: hackathon)
            } label: {
                HackathonComponent(hackathon: $hackathon, mainViewModel: mainViewModel)
            }
        }
    }
}

#Preview {
    MainView()
}
