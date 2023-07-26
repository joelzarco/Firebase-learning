//
//  AddStoreViewModel.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 26/07/23.
//

import Foundation
import SwiftUI

class AddStoreViewModel : ObservableObject{
    
    private var firestoreManager : FirestoreManager
    @Published var saved : Bool = false
    @Published var message : String = ""
    
    var name : String = ""
    var address : String = ""
    
    init(){
        firestoreManager = FirestoreManager()
    }
    
    func save(){
        let store = Store(name: name, address: address)
        firestoreManager.save(store: store) { result in
            switch result{
                case .success(let store):
                    DispatchQueue.main.async {
                        self.saved = store == nil ? false : true // if store is nil, saved = false, else saved = true
                    }

                case .failure(let error):
                    print("error in addStoreVM \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.message = Constants.Messages.storeSavedFailure
                    }
            } //sw
        }
    } //save
}
