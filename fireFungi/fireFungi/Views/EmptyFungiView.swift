//
//  EmptyFungiView.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 25/08/23.
//

import SwiftUI

struct EmptyFungiView: View {
    var body: some View {
        VStack {
            Image("empty-fungi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            
            Text("No fungi found!")
                .font(.title)
        }.padding()
    }
}
