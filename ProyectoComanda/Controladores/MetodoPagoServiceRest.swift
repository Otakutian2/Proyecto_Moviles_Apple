//
//  MetodoPagoServiceRest.swift
//  ProyectoComanda
//
//  Created by Sebastian on 8/11/23.
//

import UIKit
import Alamofire

class MetodoPagoServiceRest: NSObject {
    
    func registrarMetodoPagoRest(metodoPago:MetodoPagoDTO){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/metodo-pago/registrar",
                   method: HTTPMethod.post,
                   parameters: metodoPago,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                        print("Se genero el codigo del metodo de pago: "+String(metodoPago.id))
                    
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func editarMetodoPagoRest(metodoPago:MetodoPagoDTO){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/metodo-pago/actualizar",
                   method: HTTPMethod.put,
                   parameters: metodoPago,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in switch respuesta.result {
                case .success(_):
                        print("Se actualizo el codigo del metodo de pago: "+String(metodoPago.id))
                    
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            })
        
            }
    
    func eliminarMetodoPagoRest(id:Int){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/metodo-pago/eliminar/" + String(id),method: HTTPMethod.delete).responseData(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                    print("Se elimino el metodo de pago con el codigo" + String(id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
}
