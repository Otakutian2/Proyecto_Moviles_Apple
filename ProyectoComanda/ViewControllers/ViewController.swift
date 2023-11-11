import UIKit
import Toaster
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContraseña: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    


    @IBAction func btnLogin(_ sender: Any) {
        
                if let correo = txtEmail.text,
                   let password = txtContraseña.text {
                  
                    if  UsuarioService().login(correo: correo, password: password) {
                        Toast(text: "Inicio de sesión exitoso").show()
                       
                        performSegue(withIdentifier: "login", sender: self)
                        
                    } else {
                        Toast(text: "Inicio de sesión fallido").show()
                    }
                }

    }
    
    @IBAction func BtnCambiarContraseña(_ sender: UIButton) {
        
        performSegue(withIdentifier: "cambiar", sender: self)
        
        
    }
    
    
    
}
