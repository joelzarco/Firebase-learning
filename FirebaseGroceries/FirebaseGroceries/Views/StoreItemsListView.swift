//
//  StoreItemsListView.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 31/07/23.
//

import SwiftUI
//import Combine

struct StoreItemsListView: View {
    
    var store : StoreViewModel // no longer necc to be @State
    @StateObject private var storeItemsListVM = StoreItemListViewModel()
//    @State var cancellable : AnyCancellable?
    
    var body: some View {
        VStack{
            TextField("Enter an item name", text: $storeItemsListVM.storeItemVS.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter price", text: $storeItemsListVM.storeItemVS.price)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Enter quantity", text: $storeItemsListVM.storeItemVS.quantity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Save"){
                storeItemsListVM.addItemsToStore(storeId: store.storeId)
                storeItemsListVM.storeItemVS.name = ""
            }
            
            if let store = storeItemsListVM.store{ // use store from vm
                List(store.items, id: \.self){ item in
                    Text(item)
                }
            }
            Spacer()
        } //vs
        .onAppear{
            // refactored version
            storeItemsListVM.getStoreById(storeId: store.storeId)
            // using combine to update list with new items
//            cancellable = storeItemsListVM.$store.sink { value in
//                if let value = value{
//                    store = value
//                }
//            }
            
        }
    }
}

