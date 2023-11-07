//
//  EmpleadoActualizarViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 7/11/23.
//

import UIKit
import Toaster
import DropDown
import Alamofire

class EmpleadoActualizarViewController: UIViewController {
    var empleado : Empleado!
    var combo = DropDown()
    var idCargo = 0
    
    @IBOutlet weak var btnCategoriaVariable: UIButton!
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtDNI: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombre.text = empleado.nombre
        txtApellido.text = empleado.apellido
        txtDNI.text = empleado.dni
        txtCorreo.text = empleado.fk_empleado_usuario?.correo
        txtTelefono.text = empleado.telefono
        btnCategoriaVariable.setTitle(empleado.fk_empleado_cargo?.nombre, for: .normal)
        idCargo = Int(empleado.fk_empleado_cargo!.id)


    }
    @IBAction func btnActualizar(_ sender: Any) {
        let nombre = txtNombre.text
        let apellido = txtApellido.text
        let dni = txtDNI.text
        let correo = txtCorreo.text
        let telefono = txtTelefono.text
        //AQUÍ VAN LAS VALIDACIONES
        if(idCargo == 0){
            Toast(text: "Debes seleccionar un cargo").show()
            return
        }
        let cargo = CargoService().obtenerCargoPorId(id: Int16(idCargo))
        
        empleado.nombre = nombre
        empleado.apellido = apellido
        empleado.dni = dni
        empleado.fk_empleado_usuario?.correo = correo
        empleado.telefono = telefono
        empleado.fk_empleado_cargo = cargo
        EmpleadoService().actualizarEmpleado(empleado: empleado)
        UsuarioService().actualizarUsuario(usuario: empleado.fk_empleado_usuario!)
        Toast(text: "Empleado actualizado correctamente").show()
        NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
        self.navigationController?.popViewController(animated: true)

        
        
    }
    
    @IBAction func btnEliminar(_ sender: Any) {
        let ventana = UIAlertController(title: "Sistema", message: "¿Seguro de eliminar?", preferredStyle: .alert)
        let botonAceptar = UIAlertAction(title: "Sí", style: .default, handler: { acccion in
            UsuarioService().eliminarUsuario(usuario: self.empleado.fk_empleado_usuario!)
            EmpleadoService().eliminarEmpleado(empleado: self.empleado)
            NotificationCenter.default.post(name: Notification.Name("load"), object: nil)
            Toast(text: "Empleado eliminado").show()
            //VOLVER A LA PESTAÑA ANTERIOR
            self.navigationController?.popViewController(animated: true)
        })
        ventana.addAction(botonAceptar)
        ventana.addAction(UIAlertAction(title: "No", style: .cancel))
        present(ventana, animated: true)
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
        sender.setTitle(empleado.fk_empleado_cargo?.nombre, for: .normal)
        
        combo.show()
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            idCargo = index
            print(String(idCargo))
        }
    }
}
