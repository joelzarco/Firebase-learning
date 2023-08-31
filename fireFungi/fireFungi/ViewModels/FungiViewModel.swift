//
//  FungiViewModel.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 31/08/23.
//

import Foundation

struct FungiViewModel{
    let fungi : Fungi
    
    var fungiId : String{
        fungi.id ?? ""
    }
    var name : String{
        fungi.name
    }
    var photoUrl : String{
        fungi.url
    }
}
