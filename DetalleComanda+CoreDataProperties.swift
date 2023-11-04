//
//  DetalleComanda+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension DetalleComanda {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetalleComanda> {
        return NSFetchRequest<DetalleComanda>(entityName: "DetalleComanda")
    }

    @NSManaged public var id: Int16
    @NSManaged public var cantidadPedido: Int16
    @NSManaged public var precioUnitario: Double
    @NSManaged public var observacion: String?
    @NSManaged public var fk_detalle_comanda: Comanda?
    @NSManaged public var fk_detalle_plato: Plato?

}

extension DetalleComanda : Identifiable {

}
