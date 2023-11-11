//
//  EmpleadosServiceRest.swift
//  ProyectoComanda
//
//  Created by Sebastian on 9/11/23.
//

import UIKit
import Alamofire

class EmpleadosServiceRest: NSObject {

    
    func registrarEmpleadoRest(empleadoRest:EmpleadoDTOREST){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/empleado/registrar",
                   method: HTTPMethod.post,
                   parameters: empleadoRest,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                        print("Se genero el codigo del Empleado: "+String(empleadoRest.id))
                    
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func editarEmpleadoRest(empleadoRest:EmpleadoDTOREST){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/empleado/actualizar",
                   method: HTTPMethod.put,
                   parameters: empleadoRest,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in switch respuesta.result {
                case .success(_):
                        print("Se actualizo el codigo del Empleado: "+String(empleadoRest.id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func eliminarEmpleadoRest(id:Int){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/empleado/eliminar/" + String(id),method: HTTPMethod.delete).responseData(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                    print("Se elimino el Empleado con el codigo" + String(id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
}
