//
//  ComprobanteService.swift
//  ProyectoComanda
//
//  Created by Sebastian on 1/12/23.
//

import UIKit
import Alamofire
import FirebaseFirestore
import CoreData

class ComprobanteService: NSObject {
    
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Comprobante")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? Comprobante {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
    }
    
    func listarComprobante() -> [Comprobante] {
        var arreglo: [Comprobante] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Comprobante.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    
    func registrarComprobante(comprobante: ComprobanteDTO){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        //POR SI ACASO INSTANCIAR ENTIDAD
        let nuevoComprobante = Comprobante(context: bd)
        do{
                nuevoComprobante.id = Int16(obtenerUltimoID())
                nuevoComprobante.fechaEmision = comprobante.fechaEmision
                nuevoComprobante.precioTotalPedido = comprobante.precioTotalPedido
                nuevoComprobante.igv = comprobante.igv
                nuevoComprobante.subTotal = comprobante.subTotal
                nuevoComprobante.descuento = comprobante.descuento
                nuevoComprobante.nombreCliente = comprobante.nombreCliente
                nuevoComprobante.fk_CDP_tipocdp = comprobante.fk_CDP_tipocdp
                nuevoComprobante.fk_cdp_caja = comprobante.fk_cdp_caja
                nuevoComprobante.fk_cdp_comanda = comprobante.fk_cdp_comanda
                nuevoComprobante.fk_cdp_metodo = comprobante.fk_cdp_metodo
                nuevoComprobante.fk_cdp_empleado = comprobante.fk_cdp_empleado
            
            do {
                    // Guardar en el contexto
                    try bd.save()
                    print("Comprobante registrado exitosamente")
                } catch let error as NSError {
                    print("Error al registrar el comprobante: \(error.localizedDescription)")
                }
    }
    

}
    func registrarComprobanteRest(cdp: ComprobanteDTORest){
        AF.request("https://sistema-restaurante-rest.onrender.com/configuracion/comprobante/registrar",
                   method: HTTPMethod.post,
                   parameters: cdp,
                   encoder: JSONParameterEncoder.default).response(
            completionHandler:{
                respuesta in
                switch respuesta.result {
                case .success(_):
                        print("Se genero el codigo del comprobante: "+String(cdp.id))
                
                case .failure(let error):
                    print(error.errorDescription ?? "Hubo error al momento de hacer la peticion")
                }
            }
        )
        
    }
    func registrarCDPFirebase(cdp : ComprobanteDTORest){
        let bd = Firestore.firestore()
        let id = UUID().uuidString
        bd.collection("Comprobante").document(id).setData([
            "fechaEmision": cdp.fechaEmision,
            "precioTotalPedido": cdp.precioTotalPedido,
            "igv": cdp.igv,
            "subTotal": cdp.subTotal,
            "descuento": cdp.descuento,
            "nombreCliente": cdp.nombreCliente,
            "metodoPago": cdp.metodoPago,
            "tipoComprobante": cdp.tipoComprobante,
            "empleado": cdp.empleado,
            "comanda": cdp.comanda,
            "caja": cdp.caja
        ]){ error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                print("Comprobante registrado")
                
            }
        }
    }
    
}
