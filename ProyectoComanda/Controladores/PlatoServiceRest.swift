//
//  PlatoServiceRest.swift
//  ProyectoComanda
//
//  Created by Sebastian on 10/11/23.
//

import UIKit
import Alamofire

class PlatoServiceRest: NSObject {
    
    func registrarPlatoRest(platoRest:PlatoDTOREST){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/plato/registrar",
                   method: HTTPMethod.post,
                   parameters: platoRest,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                        print("Se genero el codigo del plato: "+String(platoRest.id))
                    
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func editarPlatoRest(platoRest:PlatoDTOREST){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/plato/actualizar",
                   method: HTTPMethod.put,
                   parameters: platoRest,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in switch respuesta.result {
                case .success(_):
                        print("Se actualizo el codigo del plato: "+String(platoRest.id))
                    
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            })
        
            }
    
    func eliminarPlatoRest(id:Int){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/plato/eliminar/" + String(id),method: HTTPMethod.delete).responseData(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                    print("Se elimino el plato con el codigo" + String(id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
}
