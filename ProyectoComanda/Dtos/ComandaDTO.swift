//
//  ComandaDTO.swift
//  ProyectoComanda
//
//  Created by Sebastian on 23/11/23.
//

import UIKit

struct ComandaDTO {

    var id :Int
    var cantidadAsientos: Int
    var precioTotal: Double
    var fechaEmision: String
    var mesa: Mesa
    var estadoComanda: EstadoComanda
    var empleado: Empleado

    
}
