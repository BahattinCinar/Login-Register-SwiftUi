//
//  ProfileView.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 5/27/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        
        if let user = viewModel.currentUser{
            List{
                Section{
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading,spacing: 4){
                            Text(user.fullName)
                                .fontWeight(.semibold)
                                .padding(.top,4)
                                
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                Section("General"){
                    HStack {
                        SettingsRowView(imageName: "gear",
                                        title: "version",
                                        tintColor: Color(.systemGray))
                        Spacer()
                        
                        Text("0.5")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Account"){
                    Button{
                        viewModel.singOut()
                    }label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Cikis Yap",
                                        tintColor: .red)
                    }
                    
                    Button{
                        Task{
                            do{
                                try await viewModel.deleteAcc()
                            }catch{
                                print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
                            }
                        }
                    }label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Hesabimi sil",
                                        tintColor: .red)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
