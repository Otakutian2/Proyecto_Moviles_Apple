//
//  Plato+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 25/10/23.
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

}

extension Plato : Identifiable {

}
