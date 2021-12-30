//
//  UpdateStore.swift
//  SwiftUI-DesignCode
//
//  Created by James Boyer on 12/30/21.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
