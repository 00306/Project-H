//
//  UserModel.swift
//  ProjectH
//
//  Created by 송지혁 on 5/18/24.
//

import Combine
import Firebase
import Foundation
import SwiftData

final class UserModel: ObservableObject {
    let authManager: FirebaseAuthService
    @Published private(set) var user: UserInfo?
    @Published private(set) var authenticationState: AuthenticationState = .unauthenticated
    @Published var bookmarks: [Hackathon] = []
    
    private var firestoreManager: FirestoreService
    private var cancellables = Set<AnyCancellable>()
    private var modelContext: ModelContext
    
    init(firestoreManager: FirestoreService = FirestoreService.shared, authManager: FirebaseAuthService = FirebaseAuthService.shared, modelContext: ModelContext) {
        self.modelContext = modelContext
        self.firestoreManager = firestoreManager
        self.authManager = authManager
        self.observeAuthState()
        
        fetchSwiftData()
    }
    
    func add(bookmark: Hackathon) {
        modelContext.insert(bookmark)
        user?.bookmarks.insert(bookmark.id!)
        fetchSwiftData()
    }
    
    func remove(bookmark: Hackathon) {
        modelContext.delete(bookmark)
        user?.bookmarks.subtract([bookmark.id!])
        fetchSwiftData()
    }
    
    func fetchSwiftData() {
        do {
            let descriptor = FetchDescriptor<Hackathon>(sortBy: [SortDescriptor(\.id)])
            self.bookmarks = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    private func observeAuthState() {
        authManager.$authenticationState
            .receive(on: DispatchQueue.main)
            .assign(to: &$authenticationState)
        
        authManager.$user
            .compactMap { $0?.toUserInfo() }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { userInfo in
                self.user = userInfo
                self.fetchBookmarkIDs()
            }
            .store(in: &cancellables)
    }
    
    func addBookmark(_ hackathon: Hackathon) {
        guard let id = hackathon.id else { return }
        user?.bookmarks.insert(id)
        
        guard let user = user else { return }
        firestoreManager.update(user)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("FINISH")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    private func fetchBookmarkIDs() {
        firestoreManager.readBookmarkIDs(user ?? UserInfo(uid: "", email: "", nickname: "", bookmarks: []))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("SUCCESS")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { bookmarks in
                self.user?.bookmarks = bookmarks
            }
            .store(in: &cancellables)

    func uploadSwiftDataToFirebase() {
        guard let user = user else { return }
        fetchSwiftData()
        firestoreService.updateBookmarks(user: user)
            .receive(on: DispatchQueue.global())
            .sink { completion in
                switch completion {
                case .finished:
                    print("SUCCESS")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
}

