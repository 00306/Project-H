//
//  BookmarkView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/23/24.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var userModel: UserModel
    @StateObject var bookmarkViewModel = BookmarkViewModel()
    
    var body: some View {
        VStack {
            ForEach(bookmarkViewModel.bookmarks) { bookmark in
                Text(bookmark.name)
                Text(bookmark.description)
                Text(bookmark.imageUrl)
            }
        }
        .onChange(of: userModel.user, { oldUser, newUser in
            if let user = newUser {
                bookmarkViewModel.fetchBookmarks(user)
            }
        })
    }
}

#Preview {
    BookmarkView()
}
