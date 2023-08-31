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

class ListViewModel : ObservableObject{
    
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    
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
