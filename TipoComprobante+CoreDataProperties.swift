//
//  TipoComprobante+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension TipoComprobante {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TipoComprobante> {
        return NSFetchRequest<TipoComprobante>(entityName: "TipoComprobante")
    }

    @NSManaged public var id: Int16
    @NSManaged public var tipo: String?
    @NSManaged public var fk_tipoCDP_CDP: NSSet?

}

// MARK: Generated accessors for fk_tipoCDP_CDP
extension TipoComprobante {

    @objc(addFk_tipoCDP_CDPObject:)
    @NSManaged public func addToFk_tipoCDP_CDP(_ value: Comprobante)

    @objc(removeFk_tipoCDP_CDPObject:)
    @NSManaged public func removeFromFk_tipoCDP_CDP(_ value: Comprobante)

    @objc(addFk_tipoCDP_CDP:)
    @NSManaged public func addToFk_tipoCDP_CDP(_ values: NSSet)

    @objc(removeFk_tipoCDP_CDP:)
    @NSManaged public func removeFromFk_tipoCDP_CDP(_ values: NSSet)

}

extension TipoComprobante : Identifiable {

}
