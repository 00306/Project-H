//
//  ContentView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        Group {
            if userModel.authenticationState == .authenticated {
                VStack {
                    MainView()
                    BookmarkView()
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
