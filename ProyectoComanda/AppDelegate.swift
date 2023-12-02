//
//  AppDelegate.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit
import CoreData

	@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let context = persistentContainer.viewContext
        //INICIALIZAR DATOS
        if TipoComprobanteService().obtenerTamano() == 0 {
            let TipoComprobante1 = TipoComprobante(context: context)
            TipoComprobante1.id = 1
            TipoComprobante1.tipo = "Nota de Venta"
            
            let TipoComprobante2 = TipoComprobante(context: context)
            TipoComprobante2.id = 2
            TipoComprobante2.tipo = "Boleta"
            
        }
        if EstablecimientoService().obtenerTamano() == 0 {
            let establecimiento = Establecimiento(context: context)
            establecimiento.id = 1
            establecimiento.nomEstablecimiento = "Sanguchería Wong"
            establecimiento.rucestablecimiento = "20217382809"
            establecimiento.telefonoEstablecimiento = "942850902"
            establecimiento.direccionestablecimiento = "Av.Izaguirre"
        }
        if MetodoPagoService().obtenerTamano() == 0 {
            let metodo1 = MetodoPago(context: context)
            metodo1.id = 1
            metodo1.nombreMetodoPago = "En Efectivo"
            
            let metodo2 = MetodoPago(context: context)
            metodo2.id = 2
            metodo2.nombreMetodoPago = "BCP"
            
            let metodo3 = MetodoPago(context: context)
            metodo3.id = 3
            metodo3.nombreMetodoPago = "BBVA"
            
            let metodo4 = MetodoPago(context: context)
            metodo4.id = 4
            metodo4.nombreMetodoPago = "Scotiabank"
            
            let metodo5 = MetodoPago(context: context)
            metodo5.id = 5
            metodo5.nombreMetodoPago = "Interbank"
        }
        
        if CargoService().obtenerTamano() == 0 {
            let cargo1 = Cargo(context: context)
            cargo1.id = 1
            cargo1.nombre = "ADMINISTRADOR"
            
            let cargo2 = Cargo(context: context)
            cargo2.id = 2
            cargo2.nombre = "MESERO"
            
            let cargo3 = Cargo(context: context)
            cargo3.id = 3
            cargo3.nombre = "CAJERO"
            
            let cargo4 = Cargo(context: context)
            cargo4.id = 4
            cargo4.nombre = "GERENTE"
        }
        
        if EstadoComandaService().obtenerTamano() == 0 {
            let estado1 = EstadoComanda(context: context)
            estado1.id = 1
            estado1.estado = "Generado"
            
            let estado2 = EstadoComanda(context: context)
            estado2.id = 2
            estado2.estado = "Pagado"
        }
        
        //guardar empleados
        if UsuarioService().obtenerTamano() == 0{
            let usuario1 = Usuario(context: context)
            usuario1.id = 1
            usuario1.correo = "admin@admin.com"
            usuario1.contrasena = "admin"
            
            let usuario2 = Usuario(context: context)
            usuario2.id = 2
            usuario2.correo = "mesero@mesero.com"
            usuario2.contrasena = "mesero"
            
            let usuario3 = Usuario(context: context)
            usuario3.id = 3
            usuario3.correo = "cajero@cajero.com"
            usuario3.contrasena = "cajero"
            
            let usuario4 = Usuario(context: context)
            usuario4.id = 4
            usuario4.correo = "gerente@gerente.com"
            usuario4.contrasena = "gerente"
        }
        
        do {
            print("Iniciando BD")
            try context.save()
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        if CajaService().obtenerTamano() == 0 {
            let caja = Caja(context: context)
            let esta = EstablecimientoService().obtenerEstablecimiento()
            caja.id = 1
            caja.fk_caja_establecimiento = esta
        }
        
        if EmpleadoService().obtenerTamano() == 0 {
            //LISTA DE CARGOS Y USUARIOS PARA INSTANCIAR
            let cargos = CargoService().obtenerCargos()
            let usuarios = UsuarioService().obtenerUsuarios()
            
            //FECHA REGISTRO
            let fechaActual = Date()
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
            let fechaActualString = dateFormat.string(from: fechaActual)
            
            //EMPLEADOS
            let empleado1 = Empleado(context: context)
            empleado1.id = 1
            empleado1.nombre = "admin"
            empleado1.telefono = "9"
            empleado1.apellido = "admin"
            empleado1.dni = "9"
            empleado1.fechaRegistro = fechaActualString
            empleado1.fk_empleado_cargo = cargos[0]
            empleado1.fk_empleado_usuario = usuarios[0]
            
            let empleado2 = Empleado(context: context)
            empleado2.id = 2
            empleado2.nombre = "mesero"
            empleado2.telefono = "98"
            empleado2.apellido = "mesero"
            empleado2.dni = "98"
            empleado2.fechaRegistro = fechaActualString
            empleado2.fk_empleado_cargo = cargos[1]
            empleado2.fk_empleado_usuario = usuarios[1]
            
            let empleado3 = Empleado(context: context)
            empleado3.id = 3
            empleado3.nombre = "cajero"
            empleado3.telefono = "97"
            empleado3.apellido = "cajero"
            empleado3.dni = "97"
            empleado3.fechaRegistro = fechaActualString
            empleado3.fk_empleado_cargo = cargos[2]
            empleado3.fk_empleado_usuario = usuarios[2]
            
            let empleado4 = Empleado(context: context)
            empleado4.id = 3
            empleado4.nombre = "gerente"
            empleado4.telefono = "96"
            empleado4.apellido = "gerente"
            empleado4.dni = "96"
            empleado4.fechaRegistro = fechaActualString
            empleado4.fk_empleado_cargo = cargos[3]
            empleado4.fk_empleado_usuario = usuarios[3]
            
            
        }
        do {
            print("Registrando empleados")
            try context.save()
        } catch let ex as NSError {
            print(ex.localizedDescription)
        }
        
        
    
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ProyectoComanda")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

