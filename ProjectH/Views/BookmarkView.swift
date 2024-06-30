//
//  BookmarkView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/23/24.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var userModel: UserModel
    
    var body: some View {
        VStack {
            Text("bookmark view")
            
            ForEach($userModel.bookmarks) { $hackathon in
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
    BookmarkView()
}
