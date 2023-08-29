//
//  LoginView.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 25/08/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var isPresented: Bool = false
    @EnvironmentObject var appState : AppState
    @ObservedObject private var loginVM = LoginViewModel()
        
    var body: some View {
        ZStack {
            
                VStack{
                    Image("mushroom")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .padding(.bottom, 20)
                    
                    TextField("Username", text: $loginVM.email)
                        .padding(.bottom, 20)
                    
                    SecureField("Password", text: $loginVM.password)
                       
                    Spacer()
                    
                    Button("Login") {
                        loginVM.login {
                            print("login succss")
                            appState.hasLoggedIn = true
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.bottom, 10)
                    
                    Button("Create account") {
                        isPresented = true
                    }.buttonStyle(SecondaryButtonStyle())
                   
                    Spacer()
                } // vs
                
//                VStack{
//                    if hasLoggedIn{
//                        FungiListView()
//                            .transition(.slide)
//                            .ignoresSafeArea()
//                    }
//                } // vs
            
            
        } // Zs
        .padding()
        .preferredColorScheme(.dark)
        .sheet(isPresented: $isPresented, content: {
            RegisterView()
        })
    } // someV
}


