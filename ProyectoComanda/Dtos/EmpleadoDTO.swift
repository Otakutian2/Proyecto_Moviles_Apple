//
//  EmpleadoDTO.swift
//  ProyectoComanda
//
//  Created by Gary on 3/11/23.
//

import UIKit

struct EmpleadoDTO {
    var id: Int
    var nombre: String
    var apellido: String
    var telefono: String
    var dni: String
    var fechaRegistro: String
    var Usuario : Usuario
    var Cargo : Cargo

}

class SessionManager {
    static let shared = SessionManager()
    
    var currentEmpleado: EmpleadoDTO?
    
    private init() {}
}

