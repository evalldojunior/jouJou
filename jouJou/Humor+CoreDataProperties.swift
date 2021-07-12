//
//  Humor+CoreDataProperties.swift
//  jouJou
//
//  Created by Dara Caroline on 12/07/21.
//
//

import Foundation
import CoreData


extension Humor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Humor> {
        return NSFetchRequest<Humor>(entityName: "Humor")
    }

    @NSManaged public var nome: String?
    @NSManaged public var imagem: Data?

}

extension Humor : Identifiable {

}
