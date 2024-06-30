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
    @EnvironmentObject var userModel: UserModel
    
    init(authService: AuthService = FirebaseAuthService.shared) {
        self.authService = authService
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if let _ = userModel.user {
                    hackathonlist
                }
                
                Button("파이어스토어") {
                    mainViewModel.fetchHackathons()
                }
                
                Button("로그아웃") {
                    authService.signOut()
                }
                
                NavigationLink {
                    BookmarkView()
                } label: {
                    Text("Go to Bookmark")
                }

            }
            .searchable(text: $mainViewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("해커톤")
            
        }
        
    }
    
    private var hackathonlist: some View {
        LazyVStack {
            ForEach($mainViewModel.searchedResult) { $hackathon in
                NavigationLink {
                    HackathonDetailView(hackathonDetailViewModel: HackathonDetailViewModel(hackathon: hackathon))
                } label: {
                    HackathonComponent(hackathon: $hackathon)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
