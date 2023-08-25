//
//  RegisterView.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 25/08/23.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.presentationMode) var presentationMode
   
    @State private var email: String = ""
    @State private var password: String = ""
        
    var body: some View {
        VStack {
            Image("mushroom")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            TextField("Email", text: $email)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
            
            Button("Create account") {
               
                
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top, 30)
            
            Spacer()
        }
        .padding()
        .defaultBackgroundView()
        .navigationTitle("Register")
        .embedInNavigationView()
       
    }
}
