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
    
    func login() async {
        await AuthManager.shared.signIn(email: email, password: password)
    }
    
    func signUp() async {
        await AuthManager.shared.signUp(email: email, password: password)
    }
}
