//
//  EstablecimientoViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit
import Toaster
import Foundation
import CoreData

class EstablecimientoViewController: UIViewController {
    
    var esta : Establecimiento!
    
    
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtRuc: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCodigo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        esta = EstablecimientoService().obtenerEstablecimiento()
        actualizarForm()
        
    }
    
    @IBAction func btnActualizar(_ sender: Any) {
        let nombre = txtNombre.text!
        let telefono = txtTelefono.text!
        let ruc = txtRuc.text!
        let direccion = txtDireccion.text!
        //VALIDACIONES
        if(nombre.isEmpty){
            Toast(text: "El nombre no debe estar vacío").show()
            return
        }
        if(nombre.count < 3){
            Toast(text: "El nombre debe contener 3 letras como mínimo").show()
            return
        }
        
        if(telefono.isEmpty){
            Toast(text: "El celular no debe estar vacío").show()
            return
        }
        let validarTel = "^[9]\\d{8}$"
        let esValido = telefono.range(of: validarTel, options: .regularExpression) != nil && telefono.count == 9
        if esValido == false {
            Toast(text: "El celular no cumple con el formato").show()
            return
        }
        let validaRUC = "^[0-9]{11}$"
        let esValido2 = ruc.range(of: validaRUC, options: .regularExpression) != nil
        if esValido2 == false{
            Toast(text: "El ruc no es válido, deben ser 11 dígitos").show()
            return
        }
        if(direccion.isEmpty){
            Toast(text: "La dirección no debe estar vacío").show()
            return
        }
        if(direccion.count < 3){
            Toast(text: "La dirección debe contener 3 letras como mínimo").show()
            return
        }
        esta.nomEstablecimiento = nombre
        esta.telefonoEstablecimiento = telefono
        esta.rucestablecimiento = ruc
        esta.direccionestablecimiento = direccion
        EstablecimientoService().actualizarEstablecimiento(establecimiento: esta)
        let estaDTO = EstablecimientoDTO(id: 1, nomEstablecimiento: esta.nomEstablecimiento!, telefonoestablecimiento: esta.telefonoEstablecimiento!, direccionestablecimiento: esta.direccionestablecimiento!, rucestablecimiento: esta.rucestablecimiento!)
        EstablecimientoServiceRest().editarEstablecimientoRest(establecimiento: estaDTO)
        Toast(text: "Establecimiento actualizado").show()
        actualizarForm()
        
    }
    func actualizarForm() {
        txtNombre.text = esta.nomEstablecimiento
        txtTelefono.text = esta.telefonoEstablecimiento
        txtRuc.text = esta.rucestablecimiento
        txtDireccion.text = esta.direccionestablecimiento
        txtCodigo.text = String(esta.id)
    }
    
    

}
