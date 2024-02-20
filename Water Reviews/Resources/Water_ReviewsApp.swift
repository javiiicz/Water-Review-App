//
//  Water_ReviewsApp.swift
//  Water Reviews
//
//  Created by Javier Carrillo on 2/13/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      // Use Firebase library to configure APIs
    FirebaseApp.configure()
    return true
  }
}


@main
struct Water_ReviewsApp: App 
{
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene
    {
        WindowGroup 
        {
            mainView()
        }
    }
}
