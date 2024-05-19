//
//  LoginView.swift
//  ProjectH
//
//  Created by 송지혁 on 5/11/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            emailField
            passwordField
            Spacer()
            loginButton
            signUpButton
        }
        .padding(20)
    }
    
    private var emailField: some View {
        VStack(alignment: .leading) {
            Text("이메일")
            TextField("이메일", text: $loginViewModel.email)
        }
    }
    private var passwordField: some View {
        VStack(alignment: .leading) {
            Text("비밀번호")
            SecureField("비밀번호", text: $loginViewModel.password)
        }
    }
    private var loginButton: some View {
        Button {
            loginViewModel.login()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 60)
                .foregroundStyle(.blue)
                .overlay {
                    Text("로그인")
                        .foregroundStyle(.white)
                }
        }
        
    }
    private var signUpButton: some View {
        Button {
            loginViewModel.signUp()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 60)
                .foregroundStyle(.purple)
                .overlay {
                    Text("회원가입")
                        .foregroundStyle(.white)
                }
        }
        
    }
}

#Preview {
    LoginView()
}
