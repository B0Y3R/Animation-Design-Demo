//
//  UserStore.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 1/2/22.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") { // this is alot like AsyncStorage in react native, basically were setting isLogged to the value we stored on last login 
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
    
}
