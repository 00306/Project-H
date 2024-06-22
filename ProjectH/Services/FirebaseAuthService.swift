//
//  AuthManager.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import Combine
import FirebaseAuth
import FirebaseAuthCombineSwift

enum AuthError: Error {
    case userNotFound
    case wrongPassword
}

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

class FirebaseAuthService: AuthService, ObservableObject {
    static let shared = FirebaseAuthService()
    let auth = Auth.auth()
    @Published var user: User? = nil
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        registerAuthStateHandler()
    }
    
    func registerAuthStateHandler() {
        if authStateHandle == nil {
            authStateHandle = auth.addStateDidChangeListener({ auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
            })
        }
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        auth.signIn(withEmail: email, password: password)
            .handleEvents(receiveOutput: { result in
                self.user = result.user
            })
            .eraseToAnyPublisher()
    }
    
    func signUp(email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        auth.createUser(withEmail: email, password: password)
            .handleEvents(receiveOutput: { result in
                self.user = result.user
            })
            .eraseToAnyPublisher()
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error)
        }
    }
}

