//
//  Comanda+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Comanda {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comanda> {
        return NSFetchRequest<Comanda>(entityName: "Comanda")
    }

    @NSManaged public var id: Int16
    @NSManaged public var cantidadAsientos: Int16
    @NSManaged public var precioTotal: Double
    @NSManaged public var fechaEmision: String?
    @NSManaged public var fk_comanda_mesa: Mesa?
    @NSManaged public var fk_comanda_estado: EstadoComanda?
    @NSManaged public var fk_comanda_empleado: Empleado?
    @NSManaged public var fk_comanda_detalleComanda: NSSet?
    @NSManaged public var fk_comanda_comprobante: Comprobante?

}

// MARK: Generated accessors for fk_comanda_detalleComanda
extension Comanda {

    @objc(addFk_comanda_detalleComandaObject:)
    @NSManaged public func addToFk_comanda_detalleComanda(_ value: DetalleComanda)

    @objc(removeFk_comanda_detalleComandaObject:)
    @NSManaged public func removeFromFk_comanda_detalleComanda(_ value: DetalleComanda)

    @objc(addFk_comanda_detalleComanda:)
    @NSManaged public func addToFk_comanda_detalleComanda(_ values: NSSet)

    @objc(removeFk_comanda_detalleComanda:)
    @NSManaged public func removeFromFk_comanda_detalleComanda(_ values: NSSet)

}

extension Comanda : Identifiable {

}
