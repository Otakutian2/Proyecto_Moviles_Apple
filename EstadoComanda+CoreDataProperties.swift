//
//  EstadoComanda+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension EstadoComanda {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EstadoComanda> {
        return NSFetchRequest<EstadoComanda>(entityName: "EstadoComanda")
    }

    @NSManaged public var id: Int16
    @NSManaged public var estado: String?
    @NSManaged public var fk_estado_comanda: NSSet?

}

// MARK: Generated accessors for fk_estado_comanda
extension EstadoComanda {

    @objc(addFk_estado_comandaObject:)
    @NSManaged public func addToFk_estado_comanda(_ value: Comanda)

    @objc(removeFk_estado_comandaObject:)
    @NSManaged public func removeFromFk_estado_comanda(_ value: Comanda)

    @objc(addFk_estado_comanda:)
    @NSManaged public func addToFk_estado_comanda(_ values: NSSet)

    @objc(removeFk_estado_comanda:)
    @NSManaged public func removeFromFk_estado_comanda(_ values: NSSet)

}

extension EstadoComanda : Identifiable {

}
