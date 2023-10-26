//
//  CategoriaPlato+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 25/10/23.
//
//

import Foundation
import CoreData


extension CategoriaPlato {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoriaPlato> {
        return NSFetchRequest<CategoriaPlato>(entityName: "CategoriaPlato")
    }

    @NSManaged public var id: Int16
    @NSManaged public var categoria: String?
    @NSManaged public var fk_categoria_plato: NSSet?

}

// MARK: Generated accessors for fk_categoria_plato
extension CategoriaPlato {

    @objc(addFk_categoria_platoObject:)
    @NSManaged public func addToFk_categoria_plato(_ value: Plato)

    @objc(removeFk_categoria_platoObject:)
    @NSManaged public func removeFromFk_categoria_plato(_ value: Plato)

    @objc(addFk_categoria_plato:)
    @NSManaged public func addToFk_categoria_plato(_ values: NSSet)

    @objc(removeFk_categoria_plato:)
    @NSManaged public func removeFromFk_categoria_plato(_ values: NSSet)

}

extension CategoriaPlato : Identifiable {

}
