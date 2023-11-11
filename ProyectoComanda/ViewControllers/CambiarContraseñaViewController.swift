//
//  CambiarContraseñaViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 10/11/23.
//

import UIKit
import Toaster

class CambiarContrasen_aViewController: UIViewController {
    
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var txtContraseña: UITextField!
    
    @IBOutlet weak var txtVerificarContraseña: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCambiarContraseña(_ sender: Any) {
        if let correo = txtCorreo.text,
           let nuevaContraseña = txtVerificarContraseña.text,
           let confirmarContraseña = txtContraseña.text {
            
            if UsuarioService().cambiarContrasena(correo: correo, nuevaContraseña: nuevaContraseña, confirmarNuevaContraseña: confirmarContraseña) {
                Toast(text: "Cambio de contraseña exitoso").show()
                	
                self.navigationController?.popViewController(animated: true)
                
               // performSegue(withIdentifier: "ogin", sender: self)
            } else {
                Toast(text: "Cambio de contraseña fallido").show()
            }
        }
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
