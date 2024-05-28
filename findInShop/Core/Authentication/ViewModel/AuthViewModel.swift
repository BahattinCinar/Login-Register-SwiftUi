//
//  AuthViewModel.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 5/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: user?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email,password: password)
            self.userSession = result.user
            await fetchUser()
        }
        catch{
            print("Debug: Failed to login with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName:String, phoneNum: String) async throws {
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = user(id: result.user.uid, fullName: fullName, email: email, phoneNum: phoneNum)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }
        catch {
            print("Debug: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func singOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAcc() async throws{
        do{
            guard let user = Auth.auth().currentUser else { return }
            let userId = Auth.auth().currentUser!.uid
            
            try await user.delete()
            
            try await Firestore.firestore().collection("users").document(userId).delete()
            
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            
        }
        catch{
            print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: user.self)
    }
}
