//
//  productView.swift
//  findInShop
//
//  Created by Behaüddin Çınar on 6/10/24.
//

import SwiftUI

struct productView: View {
    let product: String
    
    var body: some View {
        Image("\(product)")
            .resizable()
            .cornerRadius(50)
            .aspectRatio(contentMode: .fit)
            .safeAreaPadding(.all)
        Spacer()
        Text("Urunun konumu : \(product)")
            .font(.system(size: 28))
    }
}

#Preview {
    productView(product: "")
}
