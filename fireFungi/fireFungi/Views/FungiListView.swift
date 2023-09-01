//
//  FungiListView.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 25/08/23.
//

import SwiftUI
import UIKit
import URLImage

enum SourceType {
    case photoLibrary
    case camera
}

struct FungiListView: View {
    
    @EnvironmentObject var appState : AppState
    
    @State private var showImagePicker: Bool = false
    @State private var image: Image? = nil
    @State private var originalImage: UIImage? = nil
    @State private var name: String = ""
    @State private var showActionSheet: Bool = false
    @State private var sourceType: SourceType = .photoLibrary
    
    @StateObject private var listVM = ListViewModel()
    
    // remember to change security rules in cloud firestore depending on prod/test mode
    private func saveFungi(){
        DispatchQueue.main.async {
            listVM.loadingState = .loading
        }
        if let originalImage = originalImage{
            if let resizedImage = originalImage.resized(width: 1024){ // def in ext
                if let data = resizedImage.pngData(){ // Returns a data object that contains the specified image in PNG format.
                    listVM.uploadPhoto(data: data) { url in
                        if let url = url{
                            print(url)
                            listVM.save(name: name, url: url) { error in
                                if let error = error{
                                    print(error.localizedDescription)
                                }else{
                                    // after fungi being successfully saved, refresh list
                                    listVM.getAllFungiForUser()
                                    DispatchQueue.main.async {
                                        listVM.loadingState = .success
                                    }
                                }
                                image = nil
                            }
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack{
                Button(){
                    showActionSheet = true
                }label: {
                    Image(systemName: "camera")
                        .font(.title)
                }
                Text("Display List of Fungi")
                    .font(.largeTitle)
                
                if (listVM.fungi.count > 0){
                    List(listVM.fungi, id: \.fungiId) { fun in
                        funCell(fun: fun)
                    }
                }else if (listVM.loadingState == .success && listVM.fungi.count == 0){
                    // for recently signUp users
                    EmptyFungiView()
                }
                
                if image != nil{
                    PhotoPreviewView(image: $image, name: $name, save: {
                        saveFungi()
                    })
                        .shadow(radius: 5)
                }
                
                LoadingView(loadingState: listVM.loadingState)
            } // vs sub
        } // vs main
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text("Select"), message: nil, buttons: [
                .default(Text("Photo Library")) {
                    showImagePicker = true
                    sourceType = .photoLibrary
                },
                .default(Text("Camera")) {
                    showImagePicker = true
                    sourceType = .camera
                },
                .cancel()
            ])
        })
        .sheet(isPresented: $showImagePicker, content: {
            PhotoCaptureView(showImagePicker: $showImagePicker, image: $image, originalImage: $originalImage, sourceType: sourceType)
        })
    .onAppear(perform: {
        listVM.getAllFungiForUser()
    })
    }
}

struct PhotoPreviewView: View {
    
    @Binding var image: Image?
    @Binding var name: String
    let save: () -> Void
    
    var body: some View {
        
        
        ZStack {
            VStack {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    
                    TextField("Enter name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                   
                    Button("Save") {
                        save()
                        image = nil
                    }.buttonStyle(PrimaryButtonStyle())
            }.padding()
        }.background(Color(#colorLiteral(red: 0.904804647, green: 0.9049565196, blue: 0.904784739, alpha: 1)))
        
        .cornerRadius(10)
        .offset(y: 0)
        .padding()
    }
}

struct FungiCell: View {
    
    var body: some View {
        Text("Fungi Cell")
        /*
        VStack {
            URLImage(url: URL(string: fungi.photoUrl)!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            }.clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            
            Text(fungi.name)
                .font(.headline)
        } */
    }
}


struct funCell: View {
    let fun : FungiViewModel
    var body: some View {
        VStack{
            let url = URL(string: fun.photoUrl)
            
            URLImage(url!) { image, info in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(RoundedRectangle(cornerRadius: 5))
            Text(fun.name)
                .font(.body)
        }
    }
}
