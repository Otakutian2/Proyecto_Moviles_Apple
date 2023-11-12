//
//  MesaServiceRest.swift
//  ProyectoComanda
//
//  Created by Gary on 11/11/23.
//

import UIKit
import Alamofire


class MesaServiceRest: NSObject {
    
    func registrarMesaRest(mesa: MesaDTO){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/mesa/grabar",
                   method: HTTPMethod.post,
                   parameters: mesa,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                        print("Se genero el codigo de la Mesa: "+String(mesa.id))
                
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func editarMesaRest(mesa: MesaDTO){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/mesa/actualizar",
                   method: HTTPMethod.put,
                   parameters: mesa,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in switch respuesta.result {
                case .success(_):
                        print("Se actualizo el codigo de la mesa: "+String(mesa.id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func eliminarMesaRest(id:Int){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/mesa/eliminar/" + String(id),method: HTTPMethod.delete).responseData(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                    print("Se elimino la mesa con el codigo" + String(id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }

}
