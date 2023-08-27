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
    
    @StateObject private var registerVM = RegisterViewModel()
        
    var body: some View {
        VStack {
            Image("mushroom")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            TextField("Email", text: $registerVM.email)
                .padding(.bottom, 20)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $registerVM.password)
            
            Button("Create account") {
                registerVM.register {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top, 30)
            
            Spacer()
        }
        .padding()
//        .defaultBackgroundView()
        .preferredColorScheme(.dark)
        .navigationTitle("Sign up")
        .embedInNavigationView()
       
    }
}
