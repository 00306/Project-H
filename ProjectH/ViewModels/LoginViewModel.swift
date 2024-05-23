//
//  LoginViewModel.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    let authService: AuthService
    private var cancellables = Set<AnyCancellable>()
    private var firestoreManager: FirestoreManager
    
    init(firestoreManager: FirestoreManager = FirestoreManager.shared, authService: AuthService = AuthManager.shared) {
        self.authService = authService
        self.firestoreManager = firestoreManager
    }
    
    func login() {
        authService.signIn(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { result in
                
            }
            .store(in: &cancellables)

    }
    
    func signUp() {
        authService.signUp(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Succeed")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { result in
                let user = result.user
                self.updateUserInfo(user: user.toUserInfo())
            }
            .store(in: &cancellables)
    }
    
    private func updateUserInfo(user: UserInfo) {
        firestoreManager.create(user: user)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("FINIESHD")
                case .failure(let error):
                    print(error)
                }
                
            } receiveValue: { _ in
                print("Finish")
            }
            .store(in: &cancellables)

    }
}
