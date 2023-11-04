//
//  ConfiguracionViewController.swift
//  ProyectoComanda
//
//  Created by Sebastian on 3/10/23.
//

import UIKit

class ConfiguracionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func vistaEmpleado(_ sender: Any) {
        performSegue(withIdentifier: "vistaEmpleado", sender: self)
    }
    @IBAction func vistaCategoria(_ sender: Any) {
        performSegue(withIdentifier: "vistaCategoria", sender: self)
    }
    
    @IBAction func vistaPlato(_ sender: Any) {
        performSegue(withIdentifier: "vistaPlato", sender: self)
    }
    
    @IBAction func vistaMesas(_ sender: Any) {
        performSegue(withIdentifier: "vistaMesa", sender: self)
        
    }
    
    @IBAction func vistaEstablecimiento(_ sender: Any) {
        performSegue(withIdentifier: "vistaEstablecimiento", sender: self)
    }
    
    
    @IBAction func vistaMetodoPago(_ sender: Any) {
        performSegue(withIdentifier: "vistaMetodoPago", sender: self)
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
