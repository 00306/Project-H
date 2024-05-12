//
//  LoginViewModel.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    let authService: AuthService
    
    init(authService: AuthService = AuthManager.shared) {
        self.authService = authService
    }
    
    func login() async {
        await authService.signIn(email: email, password: password)
    }
    
    func signUp() async {
        await authService.signUp(email: email, password: password)
    }
}
