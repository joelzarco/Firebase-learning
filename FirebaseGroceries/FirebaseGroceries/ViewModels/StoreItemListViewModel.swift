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
    
    var storeItemId : String{
        storeItem.id ?? ""
    }
    
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
    @Published var storeItems : [StoreItemViewModel] = []
    
    var storeItemVS = StoreItemViewState()
    
    init(){
        firestoreManager = FirestoreManager()
    }
    func deleteStoreItem(storeId : String, storeItemId : String){
        firestoreManager.deleteStoreItem(storeId: storeId, storeItemId: storeItemId) { error in
            if error == nil{
                self.getStoreItemsById(storeId: storeId) // to refresh ui
            }
        }
    }
    
    func getStoreItemsById(storeId : String){
        firestoreManager.getStoreItemsBy(storeId: storeId) { result in
            switch result {
            case .success(let items):
                if let items = items{
                    DispatchQueue.main.async {
                        self.storeItems = items.map(StoreItemViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
    
    func addItemToStore(storeId : String, completion : @escaping (Error?) -> Void){
        // item properties are already in StoreItemVS but not in preferred model, use extension
        let storeItem = StoreItem.from(storeItemVS)
        firestoreManager.updateStore(storeId: storeId, storeItem: storeItem) { result in
            switch result {
            case .success( _ ):
                completion(nil)
            case .failure(let error):
                completion(error)
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
