//
//  PlatoService.swift
//  ProyectoComanda
//
//  Created by Gary on 25/10/23.
//

import UIKit
import CoreData

class PlatoService: NSObject {
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plato")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? Plato {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
    }
    func listadoPlatos() -> [Plato] {
        var arreglo: [Plato] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = Plato.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func registrarPlato(plato: PlatoDTO){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        //POR SI ACASO INSTANCIAR ENTIDAD
        let tabla = Plato(context: bd)
        do{
            tabla.id = Int16(obtenerUltimoID())
            tabla.nombre = plato.nombre
            tabla.precioPlato = plato.precioPlato
            tabla.fk_plato_categoria = plato.categoria
            try bd.save()
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func actualizarPlato(plato: Plato){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func eliminarPlato(plato: Plato){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            bd.delete(plato)
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    
    func listadoPlatosPorCategoria(categoria: String) -> [Plato] {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let bd = delegate.persistentContainer.viewContext

            // Crear una solicitud para la entidad "Plato"
            let fetchRequest: NSFetchRequest<Plato> = Plato.fetchRequest()

            // Filtrar por la categoría proporcionada
            fetchRequest.predicate = NSPredicate(format: "fk_plato_categoria.categoria == %@", categoria)

            do {
                // Ejecutar la solicitud y obtener los resultados
                let platos = try bd.fetch(fetchRequest)
                return platos
            } catch {
                // Manejar el error de alguna manera
                print("Error al obtener platos por categoría: \(error)")
                return []
            }
        }

    
    func obtenerPlato(nombre: String) -> Plato? {
           let delegate = UIApplication.shared.delegate as! AppDelegate
           let bd = delegate.persistentContainer.viewContext

           let fetchRequest: NSFetchRequest<Plato> = Plato.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "nombre == %@", nombre)

           do {
               let platos = try bd.fetch(fetchRequest)
               return platos.first
           } catch let error as NSError {
               print(error.localizedDescription)
               return nil
           }
       }


}
