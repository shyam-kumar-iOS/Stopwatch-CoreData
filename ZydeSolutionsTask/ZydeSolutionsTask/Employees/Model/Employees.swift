//
//  Employees.swift
//  ZydeSolutionsTask
//
//  Created by Shyam Kumar on 9/30/20.
//  Copyright © 2020 Shyam Kumar. All rights reserved.
//

import Foundation
import CoreData

public class Employees : NSManagedObject {
    @NSManaged var firstName : String
    @NSManaged var lastName : String
    @NSManaged var designation  : String
    @NSManaged var email  : String
    @NSManaged var phone  : String
    
}
