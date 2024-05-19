//
//  UserModel.swift
//  ProjectH
//
//  Created by 송지혁 on 5/18/24.
//

import Combine
import Firebase
import Foundation

final class UserModel: ObservableObject {
    let authManager: AuthManager
    @Published private(set) var user: UserInfo?
    @Published private(set) var authenticationState: AuthenticationState = .unauthenticated
    
    private var firestoreManager: FirestoreManager
    private var cancellables = Set<AnyCancellable>()
    
    init(firestoreManager: FirestoreManager = FirestoreManager.shared, authManager: AuthManager = AuthManager.shared) {
        self.firestoreManager = firestoreManager
        self.authManager = authManager
        self.observeAuthState()
    }
    
    private func observeAuthState() {
        authManager.$authenticationState
            .receive(on: DispatchQueue.main)
            .assign(to: &$authenticationState)
        
        authManager.$user
            .compactMap { $0?.toUserInfo() }
            .receive(on: DispatchQueue.main)
            .assign(to: &$user)
    }
    
    func bookmark(_ hackathon: Hackathon) {
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
}

extension User {
    func toUserInfo() -> UserInfo {
        return UserInfo(uid: self.uid, email: self.email ?? "", nickname: self.displayName ?? "", bookmarks: [])
    }
}