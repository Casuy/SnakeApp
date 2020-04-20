//
//  TabBar.swift
//  SnakeApp
//
//  Created by Casuy on 17/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            CameraView().tabItem {
                Image(systemName: "camera.fill")
                Text("Identify")
            }
            SnakeList().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Snakes")
            }
        }
//        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar().previewDevice("iPhone X")
    }
}
