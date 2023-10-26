//
//  CategoriaService.swift
//  ProyectoComanda
//
//  Created by Gary on 25/10/23.
//

import UIKit
import CoreData


class CategoriaService: NSObject {
    func obtenerUltimoID() -> Int {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CategoriaPlato")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        
        do{
            let resultados = try bd.fetch(fetchRequest)
            if let ultimoRegistro = resultados.first as? CategoriaPlato {
                return Int(ultimoRegistro.id) + 1
            }
            
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        return 1
    }
    func listadoCategorias() -> [CategoriaPlato] {
        var arreglo: [CategoriaPlato] = []
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            let request = CategoriaPlato.fetchRequest()
            arreglo = try bd.fetch(request)
        } catch let ex as NSError{
            print(ex.localizedDescription)
        }
        
        return arreglo
    }
    
    func registrarCategoria(cat: CategoriaPlatoDTO){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        //POR SI ACASO INSTANCIAR ENTIDAD
        let tabla = CategoriaPlato(context: bd)
        do{
            tabla.id = Int16(obtenerUltimoID())
            tabla.categoria = cat.categoria
            try bd.save()
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func actualizarCategoria(cat: CategoriaPlato){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    
    func eliminarCategoria(cat: CategoriaPlato){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        do{
            bd.delete(cat)
            try bd.save()
        }catch let ex as NSError {
            print(ex.localizedDescription)
        }
    }
    func obtenerCategoriaPorNombre(nombre: String)-> CategoriaPlato? {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let bd = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CategoriaPlato> = CategoriaPlato.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "categoria == %@", nombre)
        do {
            let categorias = try bd.fetch(fetchRequest)
            return categorias.first
        } catch let ex as NSError{
            print(ex.localizedDescription)
            return nil
        }
    }

}
