//
//  ViewController.swift
//  ProyectoComanda
//
//  Created by Gary on 30/09/23.
//

import UIKit
import Toaster

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        Toast(text: "Iniciando sesión").show()
    }
    
}

