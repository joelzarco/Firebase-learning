//
//  ContentView.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 25/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented : Bool = false
    @ObservedObject private var storeListVM = StoreListViewModel()
    
    
    var body: some View {
        VStack{
            List(storeListVM.stores, id: \.storeId){ store in
                VStack(alignment : .leading){
                    Text(store.name)
                        .font(.headline).bold()
                    Text(store.address)
                        .font(.body)
                } // vs
                
            } //lst
            .listStyle(PlainListStyle())
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
        .sheet(isPresented: $isPresented, onDismiss: { storeListVM.getAll() } ,content: { // onDissmiss sheet, getAll to refresh content
            AddStoreView()
        })
        .navigationTitle("Grocery App")
        .embedInNavigationView()
        .onAppear{
            storeListVM.getAll()
        }
    } // someV
}

