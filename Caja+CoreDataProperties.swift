//
//  Caja+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Caja {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Caja> {
        return NSFetchRequest<Caja>(entityName: "Caja")
    }

    @NSManaged public var id: Int16
    @NSManaged public var fk_caja_establecimiento: Establecimiento?
    @NSManaged public var fk_caja_cdp: NSSet?

}

// MARK: Generated accessors for fk_caja_cdp
extension Caja {

    @objc(addFk_caja_cdpObject:)
    @NSManaged public func addToFk_caja_cdp(_ value: Comprobante)

    @objc(removeFk_caja_cdpObject:)
    @NSManaged public func removeFromFk_caja_cdp(_ value: Comprobante)

    @objc(addFk_caja_cdp:)
    @NSManaged public func addToFk_caja_cdp(_ values: NSSet)

    @objc(removeFk_caja_cdp:)
    @NSManaged public func removeFromFk_caja_cdp(_ values: NSSet)

}

extension Caja : Identifiable {

}
