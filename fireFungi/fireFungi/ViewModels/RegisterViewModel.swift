//
//  RegisterViewModel.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 27/08/23.
//

import Foundation
import Firebase

class RegisterViewModel : ObservableObject{
    
    var email : String = ""
    var password : String = ""
    
    func register(completion : @escaping () -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                completion()
            }
        }
    } // reg
}
