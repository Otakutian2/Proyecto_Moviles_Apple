//
//  PrincipalViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 3/10/23.
//

import UIKit
import FacebookCore
import FacebookLogin

class PrincipalViewController: UIViewController {

    @IBOutlet weak var txtEmpleado: UITextField!
    @IBOutlet weak var btnCajaRegistradora: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Acceder a la instancia compartida de SessionManager
        let sessionManager = SessionManager.shared

        // Verificar si hay un empleado en sesión
        if let empleadoDTO = sessionManager.currentEmpleado {
            if empleadoDTO.Cargo.nombre == "GERENTE" || empleadoDTO.Cargo.nombre == "ADMINISTRADOR"{
                btnCajaRegistradora.isEnabled = true
            }else{
                btnCajaRegistradora.isEnabled = false
            }
        } else {
            // No hay empleado en sesión
            print("Ningún empleado en sesión.")
        }

        
        
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            if AccessToken.current != nil {
                LoginManager().logOut()
            }
        }
    }
    
    @IBAction func IngresarComandas(_ sender: Any) {
        performSegue(withIdentifier: "comanda", sender: self)
    }
    
    @IBAction func IngresarConfiguracion(_ sender: Any) {
        performSegue(withIdentifier: "configuracion", sender: self)
    }
    @IBAction func IngresarCaja(_ sender: Any) {
        performSegue(withIdentifier: "caja", sender: self)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
