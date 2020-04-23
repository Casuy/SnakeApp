//
//  UpdateList.swift
//  SnakeApp
//
//  Created by Casuy on 16/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "photo", title: "Bandy Bandy", text: "75.01%"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.updates) { update in
                    VStack(alignment: .center) {
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 200)
                            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .cornerRadius(20)
                            
                        
                        HStack {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                            Text(update.text)
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding(.trailing, 10)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationBarTitle(Text("History"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("          ")
            }, trailing: EditButton())
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
}

let updateData = [
    Update(image: "redbellied_black_snake", title: "Red-Bellied Black Snake", text: "54.6%"),
    Update(image: "spotted_python", title: "Spotted Python", text: "49.2%"),
]
