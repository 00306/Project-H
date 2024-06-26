//
//  HackathonView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/17/24.
//

import SwiftUI

struct HackathonComponent: View {
    @Binding var hackathon: Hackathon
    @EnvironmentObject var userModel: UserModel
    
    var isBookmarked: Bool {
        userModel.user!.bookmarks.contains(hackathon.id!)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                title
                description
                bookmarks
                dDay
            }
            Spacer()
            posterImage
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .padding()
    }
    
    private var posterImage: some View {
        AsyncImage(url: URL(string: hackathon.imageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
        } placeholder: {
            Text("표지")
        }
    }
    private var title: some View {
        Text(hackathon.name)
            .foregroundStyle(.black)
    }
    private var description: some View {
        Text(hackathon.content)
            .foregroundStyle(.black)
    }
    private var bookmarks: some View {
        VStack {
            Button {
                isBookmarked ? userModel.remove(bookmark: hackathon) : userModel.add(bookmark: hackathon)
//                mainViewModel.updateHackathon(hackathon)
            } label: {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .padding(4)
                    .contentShape(Rectangle())
            }
            
            HStack {
                Text(hackathon.hits.description)
                    .foregroundStyle(.black)
            }
        }
    }
    
    private var duration: String {
        hackathon.duration == 0 ? "day" : String(hackathon.duration)
    }
    
    private var dDay: some View {
        Text("D-\(duration)")
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.cyan)
            }
    }
}
