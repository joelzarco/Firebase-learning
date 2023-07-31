//
//  StoreItemsListView.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 31/07/23.
//

import SwiftUI

struct StoreItemsListView: View {
    
    let store : StoreViewModel
    @StateObject private var storeItemsListVM = StoreItemListViewModel()
    
    var body: some View {
        VStack{
            TextField("Enter an item name", text: $storeItemsListVM.groceryItemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Save"){
                storeItemsListVM.addItemsToStore(storeId: store.storeId)
            }
            
            List(store.items, id: \.self){ item in
                Text(item)
            }
        } //vs
    }
}

