//
//  AuthService.swift
//  ProjectH
//
//  Created by 송지혁 on 5/13/24.
//

protocol AuthService {
    func signIn(email: String, password: String) async
    func signUp(email: String, password: String) async
    func signOut()
    var authenticationState: AuthenticationState { get }
    
}
