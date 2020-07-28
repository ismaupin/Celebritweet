//
//  CelebName+CoreDataProperties.swift
//  Celebritweet
//
//  Created by Isaac Maupin on 7/25/20.
//  Copyright © 2020 Isaac Maupin. All rights reserved.
//
//

import Foundation
import CoreData


extension CelebName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CelebName> {
        return NSFetchRequest<CelebName>(entityName: "CelebName")
    }

    @NSManaged public var name: String?

}
