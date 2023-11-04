//
//  Comprobante+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Comprobante {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comprobante> {
        return NSFetchRequest<Comprobante>(entityName: "Comprobante")
    }

    @NSManaged public var id: Int16
    @NSManaged public var fechaEmision: String?
    @NSManaged public var precioTotalPedido: Double
    @NSManaged public var igv: Double
    @NSManaged public var subTotal: Double
    @NSManaged public var descuento: Double
    @NSManaged public var nombreCliente: String?
    @NSManaged public var fk_CDP_tipocdp: TipoComprobante?
    @NSManaged public var fk_cdp_caja: Caja?
    @NSManaged public var fk_cdp_comanda: Comanda?
    @NSManaged public var fk_cdp_metodo: MetodoPago?
    @NSManaged public var fk_cdp_empleado: Empleado?

}

extension Comprobante : Identifiable {

}
