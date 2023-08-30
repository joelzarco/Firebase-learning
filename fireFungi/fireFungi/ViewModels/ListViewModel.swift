//
//  ListViewModel.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 30/08/23.
//

import Foundation
import Firebase
import FirebaseStorage

class ListViewModel : ObservableObject{
    
    let storage = Storage.storage()
    
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
