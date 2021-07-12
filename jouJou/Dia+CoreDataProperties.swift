//
//  Dia+CoreDataProperties.swift
//  jouJou
//
//  Created by Dara Caroline on 12/07/21.
//
//

import Foundation
import CoreData


extension Dia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dia> {
        return NSFetchRequest<Dia>(entityName: "Dia")
    }

    @NSManaged public var data: Date?
    @NSManaged public var anotacao: Anotacao?
    @NSManaged public var humor: Humor?

}

extension Dia : Identifiable {

}
