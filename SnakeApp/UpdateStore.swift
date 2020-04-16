//
//  UpdateStore.swift
//  SnakeApp
//
//  Created by Casuy on 16/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
