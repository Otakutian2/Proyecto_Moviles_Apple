//
//  EstablecimientoServiceRest.swift
//  ProyectoComanda
//
//  Created by Gary on 11/11/23.
//

import UIKit
import Alamofire

class EstablecimientoServiceRest: NSObject {
    func editarEstablecimientoRest(establecimiento: EstablecimientoDTO){
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/establecimiento/actualizar",
                   method: HTTPMethod.put,
                   parameters: establecimiento,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in switch respuesta.result {
                case .success(_):
                        print("Se actualizo el establecimiento")
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }

}
