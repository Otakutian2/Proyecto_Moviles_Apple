//
//  EmpleadoDTOREST.swift
//  ProyectoComanda
//
//  Created by Sebastian on 9/11/23.
//

import UIKit

    struct EmpleadoDTOREST: Codable {
        var id: Int
        var nombre: String
        var apellido: String
        var telefono: String
        var dni: String
        var fechaRegistro: String
        var usuario: UsuarioDTOREST
        var cargo: CargoDTO
    }
    
struct UsuarioDTOREST : Codable{
    var id: Int
    var correo: String
    var contrasena: String
    
    func generarContraseña(apellido: String) -> String {
        let nroRamdom = Int(arc4random_uniform(UInt32(apellido.count)))
        let caracterApe = apellido[apellido.index(apellido.startIndex, offsetBy: nroRamdom)]
        var contrasenia = ""
        contrasenia.append(caracterApe.uppercased())
        contrasenia += "$"
        
        for _  in 0..<4 {
            let ramdomNumber = Int.random(in: 0..<10)
            contrasenia.append(String(ramdomNumber))
        }
        return contrasenia
    }
}


    struct CargoDTO: Codable {
    var id: Int
    var nombre: String
    }

