import UIKit
import Toaster
import CoreData
import FacebookLogin
import FacebookCore

class ViewController: UIViewController, LoginButtonDelegate {
    var dateFormat = DateFormatter()
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContraseña: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateFormat.dateFormat = "dd-MM-yyyy"
        
        let loginButton = FBLoginButton(frame: CGRect(x: 97, y: 576, width: 221, height: 31))
        loginButton.setAttributedTitle(NSAttributedString(string: "Continuar con Facebook"), for: .normal)
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
        view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print("Error al iniciar sesión con Facebook")
            return
        }
        
        let token = result?.token?.tokenString
        
        let peticion = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"], tokenString: token, version: nil, httpMethod: .get)
        
        peticion.start(){ conexion, resultado, error in
            if (error != nil) {
                print("Error al obtener el perfil")
                return
            }
            
            let resultadoArregloString = resultado as! [String: Any]
            
            let correo = resultadoArregloString["email"] as! String
            
            if (!EmpleadoService().validarCorreoExistente(correo: correo, idEmpleado: 0)) {
                self.registrarEmpleado(resultadoArregloString: resultadoArregloString)
            }
        
            let usuario = UsuarioService().obtenerUsuarioPorCorreo(correo: correo)!
            
            UsuarioService().login(correo: usuario.correo!, password: usuario.contrasena!)
            
            Toast(text: "Inicio de sesión exitoso").show()
            
            self.performSegue(withIdentifier: "login", sender: self)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
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
    
    func obtenerNombreApellido(nombreApellido: String) -> (String, String) {
        let palabras = nombreApellido.split(separator: " ")
        let nombres = palabras.prefix(2).joined(separator: " ")
        let apellidos = palabras.dropFirst(2).joined(separator: " ")
        
        return (nombres, apellidos)
    }
    
    func registrarEmpleado(resultadoArregloString: [String: Any]) {
        // Datos de FB
        let (nombres, apellidos) = self.obtenerNombreApellido(nombreApellido: resultadoArregloString["name"] as! String)
        let correo = resultadoArregloString["email"] as! String
        
        // Crear Usuario - Core
        var usuarioDTO = UsuarioDTO(id: 0, correo: correo, contrasena: "")
        usuarioDTO.contrasena = usuarioDTO.generarContraseña(apellido: apellidos)
        UsuarioService().registrarUsuario(usuario: usuarioDTO)
        
        let idUsuario = UsuarioService().obtenerUltimoID() - 1
        
        // Obtener usuario creado
        let usuarioCore = UsuarioService().obtenerUsuarioPorId(id: Int16(idUsuario))!
        
        // Instanciar Usuario - Rest
        let usuarioRest = UsuarioDTOREST(id: idUsuario, correo: usuarioDTO.correo, contrasena: usuarioDTO.contrasena)
        
        // Crear Empleado - Core
        let idEmpleado = EmpleadoService().obtenerUltimoID()
        let fechaActualString = self.dateFormat.string(from: Date())
        let cargo = CargoService().obtenerCargoPorId(id: Int16(1))!
        
        let empleadoDTO = EmpleadoDTO(id: idEmpleado, nombre: nombres, apellido: apellidos, telefono: "", dni: "", fechaRegistro: fechaActualString, Usuario: usuarioCore, Cargo: cargo)
        
        EmpleadoService().registrarEmpleado(empleado: empleadoDTO)
        
        // Crear Empleado - Rest
        let cargoRest = CargoDTO(id: Int(cargo.id), nombre: cargo.nombre!)
        
        let empleadoRest = EmpleadoDTOREST(id: idEmpleado, nombre: nombres, apellido: apellidos, telefono: "", dni: "", fechaRegistro: fechaActualString, usuario: usuarioRest, cargo: cargoRest)
        
        EmpleadosServiceRest().registrarEmpleadoRest(empleadoRest: empleadoRest)
    }
}
