//
//  ContentView.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 25/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented : Bool = false
    
    var body: some View {
        VStack{
            Text("Main view")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    isPresented = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        } // toolB
        .sheet(isPresented: $isPresented, content: {
            AddStoreView()
        })
        .navigationTitle("Grocery App")
        .embedInNavigationView()
    }
}

