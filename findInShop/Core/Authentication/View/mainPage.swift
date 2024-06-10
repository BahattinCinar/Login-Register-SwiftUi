//
//  mainPage.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 6/10/24.
//

import SwiftUI

struct mainPage: View {
    
    let products = [
        "Tutkal",
        "Katlanailir Masa",
        "Kalas",
        "Makarna",
        "Meyve",
        "Sebze",
        "Elektronik",
        "Bilgisayar",
        "Insaat Malzemeleri",
    ]
    
    
    var body: some View {

        HStack{
            VStack {
                
                NavigationStack{
                    VStack(alignment: .trailing){
                        NavigationLink(destination:ProfileView()) {
                            Text("Profilim")
                        }
                    }
                    
                    VStack {
                        List(products , id: \.self){
                            products in
                            NavigationLink(products, value: products)
                        }.navigationDestination(for: String.self, destination: productView.init)
                            .navigationTitle("Urun Sec")
                    }
                }
            }
        }.padding(.all)
        
    }
}

#Preview {
    mainPage()
}
