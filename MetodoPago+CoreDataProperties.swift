//
//  MetodoPago+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension MetodoPago {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MetodoPago> {
        return NSFetchRequest<MetodoPago>(entityName: "MetodoPago")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nombreMetodoPago: String?
    @NSManaged public var fk_metodo_cdp: NSSet?

}

// MARK: Generated accessors for fk_metodo_cdp
extension MetodoPago {

    @objc(addFk_metodo_cdpObject:)
    @NSManaged public func addToFk_metodo_cdp(_ value: Comprobante)

    @objc(removeFk_metodo_cdpObject:)
    @NSManaged public func removeFromFk_metodo_cdp(_ value: Comprobante)

    @objc(addFk_metodo_cdp:)
    @NSManaged public func addToFk_metodo_cdp(_ values: NSSet)

    @objc(removeFk_metodo_cdp:)
    @NSManaged public func removeFromFk_metodo_cdp(_ values: NSSet)

}

extension MetodoPago : Identifiable {

}
