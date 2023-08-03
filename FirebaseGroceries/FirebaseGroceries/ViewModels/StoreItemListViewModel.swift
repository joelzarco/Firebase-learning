//
//  StoreItemViewModel.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 31/07/23.
//

import Foundation

// View-State to acommodate price/quantity for items
struct StoreItemViewState{
    var name : String = ""
    var price : String = ""  // comming from textField
    var quantity : String = ""
}

struct StoreItemViewModel{
    let storeItem : StoreItem
    
    var name : String{
        storeItem.name
    }
    
    var price : Double{
        storeItem.price
    }
    
    var quantity : Int{
        storeItem.quantity
    }
}

class StoreItemListViewModel : ObservableObject{
    
    private var firestoreManager : FirestoreManager
    var groceryItemName : String = ""
    @Published var store : StoreViewModel?
    
    var storeItemVS = StoreItemViewState()
    
    init(){
        firestoreManager = FirestoreManager()
    }
    
    func getStoreById(storeId : String){
        firestoreManager.getStoreById(storeId: storeId) { result in
            switch result{
            case .success(let store):
                if let store = store{
                    DispatchQueue.main.async {
                        self.store = StoreViewModel(store: store)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addItemsToStore(storeId : String){
        firestoreManager.updateStore(storeId: storeId, values: ["items" : [groceryItemName]]) { result in
            switch result{
            case.success(let storeModel):
                if let model = storeModel{
                    DispatchQueue.main.async {
                        self.store = StoreViewModel(store: model)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            } //sw
        } //frstrMn
    } //fnc
    
}
