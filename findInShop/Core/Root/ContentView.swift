//
//  ContentView.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 4/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                mainPage()
            }
            else {
                loginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
