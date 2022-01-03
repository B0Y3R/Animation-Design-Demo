//
//  SwiftUI_DesignCodeApp.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/28/21.
//

import SwiftUI
import Firebase




class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }

}

@main
struct SwiftUI_DesignCodeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(UserStore())
        }
    }
}
