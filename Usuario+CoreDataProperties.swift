//
//  Usuario+CoreDataProperties.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//
//

import Foundation
import CoreData


extension Usuario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario> {
        return NSFetchRequest<Usuario>(entityName: "Usuario")
    }

    @NSManaged public var id: Int16
    @NSManaged public var correo: String?
    @NSManaged public var contrasena: String?
    @NSManaged public var fk_usuario_empleado: Empleado?

}

extension Usuario : Identifiable {

}
