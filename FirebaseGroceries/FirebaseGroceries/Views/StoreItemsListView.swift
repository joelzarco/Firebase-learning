//
//  StoreItemsListView.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 31/07/23.
//

import SwiftUI
import Combine


struct StoreItemsListView: View {
    
    @State var store : StoreViewModel
    @StateObject private var storeItemsListVM = StoreItemListViewModel()
    @State var cancellable : AnyCancellable?
    
    var body: some View {
        VStack{
            TextField("Enter an item name", text: $storeItemsListVM.groceryItemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Save"){
                storeItemsListVM.addItemsToStore(storeId: store.storeId)
                storeItemsListVM.groceryItemName = ""
            }
            
            List(store.items, id: \.self){ item in
                Text(item)
            }
            Spacer()
        } //vs
        .onAppear{
            // using combine to update list with new items
            cancellable = storeItemsListVM.$store.sink { value in
                if let value = value{
                    store = value
                }
            }
        }
        
    }
}

