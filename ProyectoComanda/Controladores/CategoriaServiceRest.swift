//
//  CategoriaServiceRest.swift
//  ProyectoComanda
//
//  Created by Sebastian on 9/11/23.
//

import UIKit
import Alamofire

class CategoriaServiceRest: NSObject {
    
    func registrarCategoriaRest(categoriaRest:CategoriaPlatoDTO){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/categoriaPlato/registrar",
                   method: HTTPMethod.post,
                   parameters: categoriaRest,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                        print("Se genero el codigo de la Categoria: "+String(categoriaRest.id))
                
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func editarMetodoPagoRest(categoriaRest:CategoriaPlatoDTO){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/categoriaPlato/actualizar",
                   method: HTTPMethod.put,
                   parameters: categoriaRest,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in switch respuesta.result {
                case .success(_):
                        print("Se actualizo el codigo de la categoria: "+String(categoriaRest.id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    
    func eliminarCategoriaRest(id:Int){
        
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/categoriaPlato/eliminar/" + String(id),method: HTTPMethod.delete).responseData(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                    print("Se elimino la categoria con el codigo" + String(id))
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
}
