//
//  AuthService.swift
//  ProjectH
//
//  Created by 송지혁 on 5/13/24.
//

import Combine
import FirebaseAuth

protocol AuthService {
    
    var user: User? { get }
    var authenticationState: AuthenticationState { get }
    func signIn(email: String, password: String) -> AnyPublisher<AuthDataResult, Error>
    func signUp(email: String, password: String) -> AnyPublisher<AuthDataResult, Error>
    func signOut()
}
