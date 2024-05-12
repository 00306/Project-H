//
//  AuthManager.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import FirebaseAuth
import Foundation

enum AuthError: Error {
    case userNotFound
    case wrongPassword
}

class AuthManager {
    static let shared = AuthManager()
    let auth = Auth.auth()
    var user: User? = nil
    
    func signIn(email: String, password: String) async {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            self.user = result.user
        } catch {
            print(error)
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            let _ = try await auth.createUser(withEmail: email, password: password)
        } catch {
            print(error)
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
        } catch {
            print(error)
        }
    }
}

