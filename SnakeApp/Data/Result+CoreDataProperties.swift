//
//  Result+CoreDataProperties.swift
//  SnakeApp
//
//  Created by Casuy on 21/4/20.
//  Copyright © 2020 Casuy. All rights reserved.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var confidence: String?
    @NSManaged public var position: String?

}
