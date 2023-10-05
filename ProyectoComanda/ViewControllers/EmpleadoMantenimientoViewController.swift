//
//  EmpleadoMantenimientoViewController.swift
//  ProyectoComanda
//
//  Created by Yajhura on 4/10/23.
//

import UIKit

class EmpleadoMantenimientoViewController: UIViewController {

    @IBOutlet weak var txtBuscardor: UITextField!
    @IBOutlet weak var txtNombreEmpleadoBuscar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombreEmpleadoBuscar.ponerIconoAlaDerecha(ImageViewName: "user")
        txtBuscardor.ponerIconoAlaDerecha(ImageViewName: "search")
    }
    
 

}
extension  UITextField  {
    func ponerIconoAlaDerecha(ImageViewName:String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20 ))
        imageView.image = UIImage(named: ImageViewName)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageViewContainerView.addSubview(imageView)
        rightView = imageViewContainerView
        rightViewMode = .always
        self.tintColor  = .lightGray
    }
}
