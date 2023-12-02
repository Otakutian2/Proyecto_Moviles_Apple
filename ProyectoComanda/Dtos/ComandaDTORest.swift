//
//  ComandaDTORest.swift
//  ProyectoComanda
//
//  Created by Gary on 2/12/23.
//

import UIKit

struct ComandaDTORest: Codable {
    var id :Int
    var cantidadAsientos: Int
    var precioTotal: Double
    var fechaEmision: String
    var mesa: MesaDTO
    var estadoComanda: EstadoComandaDTO
    var empleado: EmpleadoDTOREST

}
