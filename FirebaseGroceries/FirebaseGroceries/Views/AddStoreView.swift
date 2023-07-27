//
//  AddStoreView.swift
//  FirebaseGroceries
//
//  Created by sergio joel camacho zarco on 27/07/23.
//

import SwiftUI

struct AddStoreView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var addStoreVM = AddStoreViewModel()
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $addStoreVM.name)
                TextField("Address", text: $addStoreVM.address)
                HStack{
                    Spacer()
                    Button("Save"){
                        addStoreVM.save()
                    }.onChange(of: addStoreVM.saved) { newValue in
                        if newValue{ // it was successfully savved
                            dismiss()
                        }
                    }
                    Spacer()
                } //hs
//                Text(addStoreVM.message)
            } //sec
        } //frm
        .embedInNavigationView()
        .navigationTitle("Add new store")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    dismiss()
                }label: {
                    Image(systemName: "xmark")
                }
            }
        } //toolB
    }
}

