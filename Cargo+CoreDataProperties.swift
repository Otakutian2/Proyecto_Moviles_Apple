//
//  Cargo+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Cargo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cargo> {
        return NSFetchRequest<Cargo>(entityName: "Cargo")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nombre: String?
    @NSManaged public var fk_cargo_empleado: NSSet?

}

// MARK: Generated accessors for fk_cargo_empleado
extension Cargo {

    @objc(addFk_cargo_empleadoObject:)
    @NSManaged public func addToFk_cargo_empleado(_ value: Empleado)

    @objc(removeFk_cargo_empleadoObject:)
    @NSManaged public func removeFromFk_cargo_empleado(_ value: Empleado)

    @objc(addFk_cargo_empleado:)
    @NSManaged public func addToFk_cargo_empleado(_ values: NSSet)

    @objc(removeFk_cargo_empleado:)
    @NSManaged public func removeFromFk_cargo_empleado(_ values: NSSet)

}

extension Cargo : Identifiable {

}
