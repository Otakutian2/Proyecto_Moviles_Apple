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
        dateFormat.dateFormat = "dd-MM-yyyy"
        let fechaActualString = dateFormat.string(from: fechaActual)
        
        let nombre = txtNombre.text!
        let apellido = txtApellido.text!
        let dni = txtDni.text!
        let correo = txtCorreo.text!
        let telefono = txtTelefono.text!
        //AQUÍ VAN LAS VALIDACIONES
        if(idCargo == 0){
            Toast(text: "Debes seleccionar un cargo").show()
            return
        }
        let cargo = CargoService().obtenerCargoPorId(id: Int16(idCargo))
        
        var usuarioDTO = UsuarioDTO(id: 0, correo: correo, contrasena: "")
        usuarioDTO.contrasena = usuarioDTO.generarContraseña(apellido: apellido)
        UsuarioService().registrarUsuario(usuario: usuarioDTO)
        let idUsuario = UsuarioService().obtenerUltimoID() - 1
        print(String(idUsuario))
        let usuario = UsuarioService().obtenerUsuarioPorId(id: Int16(idUsuario))!
        print(String(idUsuario))
        
        let empleadoDTO = EmpleadoDTO(id: 0, nombre: nombre, apellido: apellido, telefono: telefono, dni: dni, fechaRegistro: fechaActualString, Usuario: usuario, Cargo: cargo!)
        EmpleadoService().registrarEmpleado(empleado: empleadoDTO)
        Toast(text: "Empleado registrado correctamente").show()
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
