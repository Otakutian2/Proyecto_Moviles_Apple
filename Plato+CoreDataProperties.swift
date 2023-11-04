//
//  Plato+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Plato {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plato> {
        return NSFetchRequest<Plato>(entityName: "Plato")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nombre: String?
    @NSManaged public var precioPlato: Double
    @NSManaged public var fk_plato_categoria: CategoriaPlato?
    @NSManaged public var fk_plato_detalle: NSSet?

}

// MARK: Generated accessors for fk_plato_detalle
extension Plato {

    @objc(addFk_plato_detalleObject:)
    @NSManaged public func addToFk_plato_detalle(_ value: DetalleComanda)

    @objc(removeFk_plato_detalleObject:)
    @NSManaged public func removeFromFk_plato_detalle(_ value: DetalleComanda)

    @objc(addFk_plato_detalle:)
    @NSManaged public func addToFk_plato_detalle(_ values: NSSet)

    @objc(removeFk_plato_detalle:)
    @NSManaged public func removeFromFk_plato_detalle(_ values: NSSet)

}

extension Plato : Identifiable {

}
