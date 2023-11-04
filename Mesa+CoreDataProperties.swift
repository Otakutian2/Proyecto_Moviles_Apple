//
//  Mesa+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Mesa {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mesa> {
        return NSFetchRequest<Mesa>(entityName: "Mesa")
    }

    @NSManaged public var id: Int16
    @NSManaged public var cantidadAsientos: Int16
    @NSManaged public var estado: String?
    @NSManaged public var fk_mesa_comanda: NSSet?

}

// MARK: Generated accessors for fk_mesa_comanda
extension Mesa {

    @objc(addFk_mesa_comandaObject:)
    @NSManaged public func addToFk_mesa_comanda(_ value: Comanda)

    @objc(removeFk_mesa_comandaObject:)
    @NSManaged public func removeFromFk_mesa_comanda(_ value: Comanda)

    @objc(addFk_mesa_comanda:)
    @NSManaged public func addToFk_mesa_comanda(_ values: NSSet)

    @objc(removeFk_mesa_comanda:)
    @NSManaged public func removeFromFk_mesa_comanda(_ values: NSSet)

}

extension Mesa : Identifiable {

}
