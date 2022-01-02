//
//  UserStore.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 1/2/22.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged = false
    @Published var showLogin = false
    
}
