//
//  StoreListViewModel.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 28/07/23.
//

import Foundation

class StoreListViewModel : ObservableObject{
    private var firestoreManager : FirestoreManager
    @Published var stores : [StoreViewModel] = []
    
    init(){
        firestoreManager = FirestoreManager()
    }
    
    func getAll(){
        firestoreManager.getAllStores { result in
            switch result{
            case .success(let stores):
                if let stores = stores{
                    DispatchQueue.main.async {
                        self.stores = stores.map(StoreViewModel.init) // loop over [Store], use initializer to give back [StoreViewModel]
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


struct StoreViewModel{
    
    let store : Store
    
    var storeId : String{
        store.id ?? ""
    }
    var name : String{
        store.name
    }
    var address : String{
        store.address
    }
}
