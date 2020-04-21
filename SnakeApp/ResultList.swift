//
//  ResultList.swift
//  SnakeApp
//
//  Created by Casuy on 21/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//

import SwiftUI

struct ResultList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Result.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Result.name, ascending: true),
                          NSSortDescriptor(keyPath: \Result.image, ascending: true),
                          NSSortDescriptor(keyPath: \Result.confidence, ascending: true),
                          NSSortDescriptor(keyPath: \Result.position, ascending: true),]
    ) var results : FetchedResults<Result>
    
    @State var image : Data = .init(count: 0)
    
    
    var body: some View {
        NavigationView {
            List(results, id: \.self) { result in
                VStack {
                    Image(uiImage: UIImage(data: result.image ?? self.image)!)
                    
                    Text("\(result.name ?? "")")
                    
                    Text("\(result.confidence ?? "")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        
        
    }
}

struct ResultList_Previews: PreviewProvider {
    static var previews: some View {
        ResultList()
    }
}
