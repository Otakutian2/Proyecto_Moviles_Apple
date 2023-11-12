//
//  EmpleadoDetalleViewControler.swift
//  ProyectoComanda
//
//  Created by Yajhura on 4/10/23.
//

import UIKit
import Toaster
import DropDown
import Alamofire

class EmpleadoDetalleViewControler: UIViewController {
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtDni: UITextField!
    @IBOutlet weak var txtApellido: UITextField!

    var combo = DropDown()
    var idCargo = 0


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func btnCargos(_ sender: UIButton) {
        let listaCargos = CargoService().obtenerCargos()
        var cargosString : [String] = ["Seleccionar"]
        for cargo in listaCargos {
            cargosString.append(cargo.nombre!)
        }
            combo.dataSource = cargosString
           
            combo.dataSource = cargosString
            sender.setTitle(cargosString[0], for: .normal)
        
        combo.anchorView = sender
        combo.bottomOffset = CGPoint(x: 0, y: (combo.anchorView?.plainView.bounds.height)!)
        
        combo.show()
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idCargo = index
            print(String(idCargo))
        }
    }
    
    @IBAction func btnCrear(_ sender: Any) {
        let fechaActual = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let fechaActualString = dateFormat.string(from: fechaActual)
        
        let nombre = txtNombre.text!
        let apellido = txtApellido.text!
        let dni = txtDni.text!
        let correo = txtCorreo.text!
        let telefono = txtTelefono.text!
        //AQUÍ VAN LAS VALIDACIONES
        let validacion = validarEmpleado(nombre: nombre, apellido: apellido, telefono: telefono, dni: dni, fechaRegistro: fechaActualString, correo: correo, cargo: Int16(idCargo))
        
        if validacion.count > 0 {
                    Toast(text: validacion).show()
                    return
                }
        
        let cargo = CargoService().obtenerCargoPorId(id: Int16(idCargo  ))!
        
        var usuarioDTO = UsuarioDTO(id: 0, correo: correo, contrasena: "")
        
        let idUsuariRest = UsuarioService().obtenerUltimoID() - 1
        
        let usuarioRest = UsuarioService().obtenerUsuarioPorId(id: Int16(idUsuariRest))
        
        var usuarioDTOREST = UsuarioDTOREST(id: Int(usuarioRest!.id), correo: usuarioRest!.correo!, contrasena: "")
        
        usuarioDTO.contrasena = usuarioDTO.generarContraseña(apellido: apellido)
        
        usuarioDTOREST.contrasena = usuarioDTOREST.generarContraseña(apellido: apellido)
        
        
        
        UsuarioService().registrarUsuario(usuario: usuarioDTO)
        
        
        let idUsuario = UsuarioService().obtenerUltimoID() - 1
        print(String(idUsuario))
        
        let usuario = UsuarioService().obtenerUsuarioPorId(id: Int16(idUsuario))!
        
      
        print(String(idUsuario))
        
        
        
        let empleadoDTO = EmpleadoDTO(id: 0, nombre: nombre, apellido: apellido, telefono: telefono, dni: dni, fechaRegistro: fechaActualString, Usuario: usuario, Cargo: cargo)
        
        let cargoRest = CargoDTO(id: Int(cargo.id), nombre: cargo.nombre!)
        
        var empleadoDTOREST = EmpleadoDTOREST(id: 0, nombre: nombre, apellido: apellido, telefono: telefono, dni: dni, fechaRegistro: fechaActualString, usuario: usuarioDTOREST, cargo: cargoRest)
                   
                       
        EmpleadoService().registrarEmpleado(empleado: empleadoDTO)
        
        let idRest = EmpleadoService().obtenerUltimoID()
        
        
        empleadoDTOREST.id = idRest
        print(String(usuarioDTO.contrasena))
        print(idRest)
        
        EmpleadosServiceRest().registrarEmpleadoRest(empleadoRest: empleadoDTOREST)
        Toast(text: "Empleado registrado correctamente").show()
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func validarEmpleado(nombre: String, apellido: String , telefono: String , dni: String ,  fechaRegistro: String , correo:String ,cargo: Int16) -> String {
        
        if  (nombre.isEmpty || apellido.isEmpty || telefono.isEmpty || dni.isEmpty || fechaRegistro.isEmpty || correo.isEmpty || cargo == 0) {
               return "Todos los campos son requeridos."
           }
           
           let correoRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let correoPredicado = NSPredicate(format:"SELF MATCHES %@", correoRegex)
           if !correoPredicado.evaluate(with: correo) {
               return "El correo electrónico no es válido."
           }
           
            if telefono.count != 9 {
               return "El teléfono debe tener exactamente 9 caracteres."
           }
           
           
           if  dni.count != 8 {
               return "El DNI debe tener exactamente 8 caracteres."
           }
            
            
            if EmpleadoService().validarDNIExistente(dni:  dni,idEmpleado: 0) {
                return "El DNI ya se encuentra registrado."
            }
            
            if EmpleadoService().validarCorreoExistente(correo: correo, idEmpleado: 0) {
                return "El correo ya se encuentra registrado."
            }
            
           return ""
            
            
       }
    
}
