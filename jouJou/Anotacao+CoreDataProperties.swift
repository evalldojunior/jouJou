//
//  Anotacao+CoreDataProperties.swift
//  jouJou
//
//  Created by Dara Caroline on 12/07/21.
//
//

import Foundation
import CoreData


extension Anotacao {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Anotacao> {
        return NSFetchRequest<Anotacao>(entityName: "Anotacao")
    }

    @NSManaged public var data: Date?
    @NSManaged public var desenho: Data?

}

extension Anotacao : Identifiable {

}
