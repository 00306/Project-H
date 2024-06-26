//
//  BookmarkViewModel.swift
//  ProjectH
//
//  Created by 송지혁 on 5/23/24.
//

import Combine
import Foundation

class BookmarkViewModel: ObservableObject {
    @Published var bookmarks: [Hackathon] = []
    
    let firestoreManager: FirestoreService
    var cancellables = Set<AnyCancellable>()
    
    init(firestoreManager: FirestoreService = FirestoreService.shared) {
        self.firestoreManager = firestoreManager
    }
    
    func fetchBookmarks(_ user: UserInfo) {
        firestoreManager.readBookmarks(user)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { hackathons in
                self.bookmarks = hackathons
            }
            .store(in: &cancellables)
    }
}
