//
//  Establecimiento+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Establecimiento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Establecimiento> {
        return NSFetchRequest<Establecimiento>(entityName: "Establecimiento")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nomEstablecimiento: String?
    @NSManaged public var telefonoEstablecimiento: String?
    @NSManaged public var rucestablecimiento: String?
    @NSManaged public var fk_establecimiento_caja: NSSet?

}

// MARK: Generated accessors for fk_establecimiento_caja
extension Establecimiento {

    @objc(addFk_establecimiento_cajaObject:)
    @NSManaged public func addToFk_establecimiento_caja(_ value: Caja)

    @objc(removeFk_establecimiento_cajaObject:)
    @NSManaged public func removeFromFk_establecimiento_caja(_ value: Caja)

    @objc(addFk_establecimiento_caja:)
    @NSManaged public func addToFk_establecimiento_caja(_ values: NSSet)

    @objc(removeFk_establecimiento_caja:)
    @NSManaged public func removeFromFk_establecimiento_caja(_ values: NSSet)

}

extension Establecimiento : Identifiable {

}
