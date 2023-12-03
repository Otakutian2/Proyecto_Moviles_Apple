//
//  ComandaService.swift
//  ProyectoComanda
//
//  Created by Sebastian on 23/11/23.
//

import UIKit
import CoreData

class ComandaService: NSObject {
    
    
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Comanda")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? Comanda {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
    }
    
    func listadoComanda() -> [Comanda] {
        var arreglo: [Comanda] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Comanda.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func registrarComandaYDetalles(comanda: ComandaDTO, detalles: [DetalleComandaDTO]) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        
       

        // Inicia una transacción de Core Data
        bd.performAndWait {
            do {
                // Registra la comanda en Core Data
                let comandaEntity = Comanda(context: bd)
                comandaEntity.id = Int16(obtenerUltimoID())
                comandaEntity.cantidadAsientos = Int16(comanda.cantidadAsientos)
                comandaEntity.precioTotal = comanda.precioTotal
                comandaEntity.fechaEmision = comanda.fechaEmision
                comandaEntity.fk_comanda_mesa = comanda.mesa
                comandaEntity.fk_comanda_empleado = comanda.empleado
                comandaEntity.fk_comanda_estado = comanda.estadoComanda
                
                let idComanda = ComandaService().obtenerComandaPorId(id: comandaEntity.id)
                
                let idDetalle = DetaleComandaService().obtenerUltimoID()
                // Registra los detallesComanda en Core Data y los asocia con la comanda
                for detalle in detalles {
                    let detalleEntity = DetalleComanda(context: bd)
                    detalleEntity.id = Int16(idDetalle)
                    detalleEntity.cantidadPedido = Int16(detalle.cantidadPedido)
                    detalleEntity.precioUnitario = detalle.precioUnitario
                    detalleEntity.observacion = detalle.obsevacion
                    detalleEntity.fk_detalle_plato = detalle.plato
                    detalleEntity.fk_detalle_comanda = idComanda
                }

                // Guarda los cambios en Core Data
                try bd.save()

            } catch let error as NSError {
                print("Error al registrar comanda y detalles: \(error.localizedDescription)")
            }
        }
    }
    
    func obtenerComandaPorId(id: Int16)-> Comanda? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Comanda> = Comanda.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let comanda = try bd.fetch(fetchRequest)
            return comanda.first
        } catch let ex as NSError{
            print(ex.localizedDescription)
            return nil
        }
    }
    
    func obtenerEstadoPorId(id: Int16, estado: String) -> EstadoComanda? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<EstadoComanda> = EstadoComanda.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d AND estado == %@", id, estado)
        do {
            let estadoComanda = try bd.fetch(fetchRequest)
            return estadoComanda.first
        } catch let error as NSError {
            print("Error al obtener estado por id: \(error.localizedDescription)")
            return nil
        }
    }

    
    func actualizarEstadoComanda(id: Int16) {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let bd = delegate.persistentContainer.viewContext

            if let comanda = obtenerComandaPorId(id: id),
                let nuevoEstado = obtenerEstadoPorId(id: 2, estado: "Pagado") {
                comanda.fk_comanda_estado = nuevoEstado

                do {
                    try bd.save()
                } catch let error as NSError {
                    print("Error al actualizar el estado de la comanda: \(error.localizedDescription)")
                }
            }
        }
    
    func listadoComandaPorEstado(estado: String) -> [Comanda] {
        var arreglo: [Comanda] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        
        do {
            let request = Comanda.fetchRequest() as NSFetchRequest<Comanda>
            // Agrega un predicado para filtrar por estado
            request.predicate = NSPredicate(format: "fk_comanda_estado.estado == %@", estado)
            
            arreglo = try bd.fetch(request)
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        
        return arreglo
    }

    func actualizarComandaYDetalles(comanda: Comanda, nuevosDetalles: [DetalleComandaDTO]) {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let bd = delegate.persistentContainer.viewContext

            // Inicia una transacción de Core Data
            bd.performAndWait {
                do {
                    // Obtén la comanda existente por su ID
                    guard let comandaExistente = ComandaService().obtenerComandaPorId(id: Int16(comanda.id)) else {
                        print("No se encontró la comanda existente.")
                        return
                    }

                    // Actualiza los atributos de la comanda
                   
                    comandaExistente.precioTotal = comanda.precioTotal

                    // Registra los nuevos detallesComanda y los asocia con la comanda
                    for nuevoDetalle in nuevosDetalles {
                        let detalleComandaporId = DetaleComandaService().obtenerDetalleComandaporId(id: Int16(nuevoDetalle.id))
                        
                        if detalleComandaporId == nil{
                            let nuevoDetalleEntity = DetalleComanda(context: bd)
                            nuevoDetalleEntity.id = Int16(DetaleComandaService().obtenerUltimoID())
                            nuevoDetalleEntity.cantidadPedido = Int16(nuevoDetalle.cantidadPedido)
                            nuevoDetalleEntity.precioUnitario = nuevoDetalle.precioUnitario
                            nuevoDetalleEntity.observacion = nuevoDetalle.obsevacion
                            nuevoDetalleEntity.fk_detalle_plato = nuevoDetalle.plato
                            nuevoDetalleEntity.fk_detalle_comanda = comandaExistente
                            
                        }
                    }

                    // Guarda los cambios en Core Data
                    try bd.save()

                } catch let error as NSError {
                    print("Error al actualizar comanda y detalles: \(error.localizedDescription)")
                }
            }
        }
   
    
    
}
