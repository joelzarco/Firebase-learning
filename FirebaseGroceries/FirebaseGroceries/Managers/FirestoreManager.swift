//
//  FirestoreManager.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 26/07/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirestoreManager{
    private var db : Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func save(store : Store, completion : @escaping(Result<Store?, Error>) -> Void){
        do{
            let ref = try db.collection("stores").addDocument(from: store)
            ref.getDocument { snapshot, error in
                guard let snapshot = snapshot, error == nil else{
                    completion(.failure(error!)) // 
                    return
                }
                let store = try? snapshot.data(as: Store.self)
                completion(.success(store))
            }
        } //do
        catch let error{
            completion(.failure(error))
        }
    } // save
    
    func getAllStores(completion : @escaping(Result<[Store]?, Error>) -> Void ){
        db.collection("stores").getDocuments { snapshot, error in
            if let error = error{
                completion(.failure(error))
            }else{
                if let snapshot = snapshot{
                    let stores : [Store]? = snapshot.documents.compactMap { doc in
                        var store = try? doc.data(as: Store.self)
                        if (store != nil){
                            store!.id = doc.documentID
                        }
                        return store
                    }
                    completion(.success(stores))
                }
            }
        }
    }
}
