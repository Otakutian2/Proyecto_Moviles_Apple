//
//  Empleado+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Empleado {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Empleado> {
        return NSFetchRequest<Empleado>(entityName: "Empleado")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nombre: String?
    @NSManaged public var apellido: String?
    @NSManaged public var dni: String?
    @NSManaged public var fechaRegistro: String?
    @NSManaged public var telefono: String?
    @NSManaged public var fk_empleado_cargo: Cargo?
    @NSManaged public var fk_empleado_usuario: Usuario?
    @NSManaged public var fk_empleado_comanda: NSSet?
    @NSManaged public var fk_empleado_comprobante: Comprobante?

}

// MARK: Generated accessors for fk_empleado_comanda
extension Empleado {

    @objc(addFk_empleado_comandaObject:)
    @NSManaged public func addToFk_empleado_comanda(_ value: Comanda)

    @objc(removeFk_empleado_comandaObject:)
    @NSManaged public func removeFromFk_empleado_comanda(_ value: Comanda)

    @objc(addFk_empleado_comanda:)
    @NSManaged public func addToFk_empleado_comanda(_ values: NSSet)

    @objc(removeFk_empleado_comanda:)
    @NSManaged public func removeFromFk_empleado_comanda(_ values: NSSet)

}

extension Empleado : Identifiable {

}
