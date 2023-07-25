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
    @State private var tasks : [Task] = []
    
    var body: some View {
        VStack {
            TextField("Enter task", text: $title)
                .textFieldStyle(.roundedBorder)
            Button("Save"){  // this whole process will be moved to view model
                let task = Task(title: title)
                saveTask(task: task)
            } // bttn
            List(tasks, id: \.title){ tsk in
                Text(tsk.title)
            }
        } // vs
        .padding()
        .onAppear{
            fetchAllTasks()
        }
    }
    
    private func saveTask(task : Task){
        do{ // creates a new collection named tasks
            try db.collection("tasks").addDocument(from: task){ err in
                if let err = err{
                    print(err.localizedDescription)
                }else{
                    title = ""
                    print("successfully saved")
                    fetchAllTasks() // to inmediately update list
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    } // saveTask
    
    private func fetchAllTasks(){
        db.collection("tasks").getDocuments { snapshot, error in
            if let error = error{
                print(error.localizedDescription)
            }else{
                if let snapshot = snapshot{
                   tasks = snapshot.documents.compactMap{ doc in // remove nils with compactMap
                        return try? doc.data(as: Task.self)
                    }
                }
            }
        }
    } // fetch
}
