//
//  ContentView.swift
//  HelloFirebase
//
//  Created by sergio joel camacho zarco on 23/07/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    
    let db = Firestore.firestore()
    @State private var title : String = ""
    
    var body: some View {
        VStack {
            TextField("Enter task", text: $title)
                .textFieldStyle(.roundedBorder)
            Button("Save"){  // this whole process will be moved to view model
                let task = Task(title: title)
                saveTask(task: task)
            } // bttn
        } // vs
        .padding()
    }
    
    private func saveTask(task : Task){
        do{ // creates a new collection named tasks
            try db.collection("tasks").addDocument(from: task){ err in
                if let err = err{
                    print(err.localizedDescription)
                }else{
                    title = ""
                    print("successfully saved")
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    } // saveTask
}
