//
//  loginView.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 4/24/24.
//

import SwiftUI

struct loginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                Image("app-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150,height: 150)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24){
                    inputView(text: $email,
                              title: "Mail Adresiniz",
                              placeholder: "ornek@ornek.com")
                        .autocapitalization(.none)
                    
                    inputView(text: $password,
                              title: "Sifreniz",
                              placeholder: "sifre",
                              isSecureField: true)
                    
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Button{
                    Task{
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                }label: {
                    HStack{
                        Text("Giris Yap")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding(.top,20)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Hesabiniz yok mu?")
                        Text("Kayit Olun")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }

            }
        }
    }
}

extension loginView: AuthenticationFormProtocol{
    
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
}

#Preview {
    loginView()
}
