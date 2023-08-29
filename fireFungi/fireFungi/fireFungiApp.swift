//
//  fireFungiApp.swift
//  fireFungi
//
//  Created by sergio joel camacho zarco on 25/08/23.
//

import SwiftUI
import FirebaseCore

class AppState : ObservableObject{
    @Published var hasLoggedIn : Bool
    
    init(hasLoggedIn: Bool) {
        self.hasLoggedIn = hasLoggedIn
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct fireFungiApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var appState = AppState(hasLoggedIn: false)
    
  var body: some Scene {
    WindowGroup {
        
          if appState.hasLoggedIn{
              FungiListView()
                  .environmentObject(appState)
          }else{
              LoginView()
                  .environmentObject(appState)
          }
    }
  }
}
