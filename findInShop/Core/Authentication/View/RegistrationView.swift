//
//  RegistrationView.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 5/27/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var pass = ""
    @State private var confirmPass = ""
    @State private var name = ""
    @State private var surName = ""
    @State private var phoneNum = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image("app-logo")
                .resizable()
                .scaledToFill()
                .frame(width: 150,height: 150)
                .padding(.vertical, 32)
            
            VStack(spacing: 24){
                HStack {
                    inputView(text: $name,
                              title: "Isminiz",
                              placeholder: "Isminizi giriniz")
                    
                    inputView(text: $surName,
                              title: "Soy Isminiz",
                              placeholder: "Soy Isminizi Giriniz")
                }
                
                HStack {
                    inputView(text: $phoneNum,
                              title: "Telefon Numaraniz",
                              placeholder: "Telefon Numaranizi Giriniz")
                    .keyboardType(.numberPad)
                    
                    inputView(text: $email,
                              title: "Mail Adresiniz",
                              placeholder: "ornek@ornek.com")
                        .autocapitalization(.none)
                }
                
                HStack{
                    inputView(text: $pass,
                              title: "Sifreniz",
                              placeholder: "sifre",
                              isSecureField: true)
                    
                    ZStack(alignment: .trailing) {
                        inputView(text: $confirmPass,
                                  title: "Sifrenizi Dogrulayin",
                                  placeholder: "sifre",
                                  isSecureField: true)
                        
                        if !pass.isEmpty && !confirmPass.isEmpty {
                            if pass == confirmPass{
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                }.autocapitalization(.none)
                
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Spacer()
            
            VStack(spacing: 20) {
                Button{
                    Task{
                        try await viewModel.createUser(withEmail: email,
                                                       password: pass,
                                                       fullName: name + " " + surName,
                                                       phoneNum: phoneNum)
                    }
                } label:{
                    HStack{
                        Text("Kayit Ol")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                
                Button{
                    dismiss()
                } label: {
                    Text("Hesabiniz var mi?")
                    Text("Giris yap")
                        .fontWeight(.bold)
                }
                .font(.system(size:14))
            }
            
            
            
        }
    }
}

extension RegistrationView: AuthenticationFormProtocol{
    
    var formIsValid: Bool {
        
        return !email.isEmpty
        && email.contains("@")
        && !pass.isEmpty
        && pass.count > 5
        && !name.isEmpty
        && !surName.isEmpty
        && confirmPass == pass
        && phoneNum.count > 10
        && phoneNum.count < 12
        && !phoneNum.isEmpty
    }
}



#Preview {
    RegistrationView()
}
