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
        
        let metodoPago : [String : Any] = [
            "metodo": cdp.metodoPago.nombreMetodoPago
        ]
        let tipo : [String : Any] = [
            "tipo": cdp.tipoComprobante.tipo
        ]
        let empleado : [String : Any] = [
            "nombre": cdp.empleado.nombre,
            "apellido": cdp.empleado.apellido,
            "telefono": cdp.empleado.telefono,
            "dni": cdp.empleado.dni,
            "fechaRegistro": cdp.empleado.fechaRegistro,
            "cargo": cdp.empleado.cargo.nombre
        ]
        let comanda : [String : Any] = [
            "cantidadAsientos": cdp.comanda.cantidadAsientos,
            "precioTotal": cdp.comanda.precioTotal,
            "fechaEmision": cdp.comanda.fechaEmision,
            "mesa": cdp.comanda.mesa.id,
            "estadoComanda": cdp.comanda.estadoComanda.estado,
            "empleadomesero": cdp.comanda.empleado.nombre
        ]
        let Establecimiento : [String : Any] = [
            "nomEstablecimiento": cdp.caja.Establecimiento.nomEstablecimiento,
            "telefono": cdp.caja.Establecimiento.telefonoestablecimiento,
            "direccion": cdp.caja.Establecimiento.direccionestablecimiento,
            "ruc": cdp.caja.Establecimiento.rucestablecimiento
        ]
        let caja : [String : Any] = [
            "idCaja": cdp.caja.id,
            "establecimiento": Establecimiento
        ]
        
        let userData : [String: Any] = [
            "fechaEmision": cdp.fechaEmision,
            "precioTotalPedido": cdp.precioTotalPedido,
            "igv": cdp.igv,
            "subTotal": cdp.subTotal,
            "descuento": cdp.descuento,
            "nombreCliente": cdp.nombreCliente,
            "metodoPago": metodoPago,
            "tipoComprobante": tipo,
            "empleado": empleado,
            "comanda": comanda,
            "caja": caja
        ]
        bd.collection("Comprobante").addDocument(data: userData) { error in
            if let error = error {
                print("error al guardar")
            } else {
                print("Datos guardados")
            }
        }
        /*
        bd.collection("Comprobante").addDocument(id).setData([
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
                print(e.localizedDescription + "ERROR DE FIREBASE")
            } else {
                print("Comprobante registrado")
                
            }
        }*/
    }
    
}
