//
//  ListViewModel.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 30/08/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

enum LoadingState{
    case idle
    case loading
    case success
    case failure
}

class ListViewModel : ObservableObject{
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    @Published var fungi : [FungiViewModel] = []
    @Published var loadingState : LoadingState = .idle
    
    func getAllFungiForUser(){
        
        DispatchQueue.main.async {
            self.loadingState = .loading
        }
        
        guard let currentUser = Auth.auth().currentUser else{
            return
        }
        db.collection("fungi").whereField("userId", isEqualTo: currentUser.uid).getDocuments{ (snap, err) in
            if let err = err{
                print(err.localizedDescription)
                DispatchQueue.main.async {
                    self.loadingState = .failure
                }
            }else{
                if let snap = snap{
                    let fungi : [FungiViewModel] = snap.documents.compactMap { doc in
                        var fungi = try? doc.data(as: Fungi.self)
                        fungi?.id = doc.documentID
                        if let fungi = fungi{
                            return FungiViewModel(fungi: fungi)
                        }
                        return nil
                    }
                    DispatchQueue.main.async {
                        self.fungi = fungi
                        self.loadingState = .success
                    }
                }
            }
        }
    }
    
    
    func save(name : String, url : URL, completion : (Error?) -> Void){
        
        guard let currrentUser = Auth.auth().currentUser else{
            return
        }
        
        do{
            let _ = try db.collection("fungi").addDocument(from: Fungi(name: name, url: url.absoluteString, userId: currrentUser.uid))
            completion(nil)
        } catch let error{
            completion(error)
        }
        
    }
    
    func uploadPhoto(data : Data, completion : @escaping (URL?) -> Void){
        // on succes gives back url of uploaded image
        let imageName = UUID().uuidString
        let storageRef = storage.reference()
        let photoRef = storageRef.child("images/\(imageName).png")
        
        photoRef.putData(data, metadata: nil){ metadata, error in
            photoRef.downloadURL { url, error in
                if let error = error{
                    print(error.localizedDescription)
                } else{
                    completion(url)
                }
            }
        }
    } // upload
    
}
