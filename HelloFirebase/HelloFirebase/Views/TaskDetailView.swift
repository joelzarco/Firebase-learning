//
//  TaskDetailView.swift
//  HelloFirebase
//
//  Created by sergio joel camacho zarco on 25/07/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct TaskDetailView: View {
    
    let db : Firestore = Firestore.firestore()
    
    let task : Task
    @State private var title : String = ""
    
    var body: some View {
        VStack{
            TextField(task.title, text: $title)
                .textFieldStyle(.roundedBorder)
            Button("Update"){
                updateTask()
            }
        } // vs
    }
    
    private func updateTask(){
        db.collection("tasks").document(task.id!).updateData(["title" : title]){ error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("updated successfully :)")
            }
        }
    }
}

