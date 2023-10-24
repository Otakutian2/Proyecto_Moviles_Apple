//
//  MetodoPago+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 23/10/23.
//
//

import Foundation
import CoreData


extension MetodoPago {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MetodoPago> {
        return NSFetchRequest<MetodoPago>(entityName: "MetodoPago")
    }

    @NSManaged public var id: Int16
    @NSManaged public var nombreMetodoPago: String?
    
    //haciendo referencia a los listado

}

extension MetodoPago : Identifiable {

}
