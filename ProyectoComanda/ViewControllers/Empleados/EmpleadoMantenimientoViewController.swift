//
//  EmpleadoMantenimientoViewController.swift
//  ProyectoComanda
//
//  Created by Yajhura on 4/10/23.
//

import UIKit
import DropDown

class EmpleadoMantenimientoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tblEmpleados: UITableView!
    @IBOutlet weak var txtBuscardor: UITextField!
    @IBOutlet weak var txtNombreEmpleadoBuscar: UITextField!
    
    var listaEmpleados: [Empleado] = []
    var combo = DropDown()
    var cargoFiltro: String = "Cargo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombreEmpleadoBuscar.ponerIconoAlaDerecha(ImageViewName: "user")
        txtBuscardor.ponerIconoAlaDerecha(ImageViewName: "search")
        
        listaEmpleados = EmpleadoService().obtenerEmpleados()
        tblEmpleados.dataSource = self
        tblEmpleados.rowHeight = 130
        tblEmpleados.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(cargarLista), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func cargarLista(){
        listaEmpleados = EmpleadoService().obtenerEmpleados()
        
        tblEmpleados.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listaEmpleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tblEmpleados.dequeueReusableCell(withIdentifier: "item_empleado") as! EmpleadoTableViewCell
        data.lblDNI.text = listaEmpleados[indexPath.row].dni
        data.lblCargo.text = listaEmpleados[indexPath.row].fk_empleado_cargo?.nombre
        data.lblFecha.text = listaEmpleados[indexPath.row].fechaRegistro
        data.lblNombre.text = listaEmpleados[indexPath.row].nombre
        data.lblTelefono.text = listaEmpleados[indexPath.row].telefono

        return data

    }
    
    
    @IBAction func comboCargos(_ sender: UIButton) {
        let listaCargos = CargoService().obtenerCargos()
        var cargosString : [String] = ["Cargo"]
        for cargo in listaCargos {
            cargosString.append(cargo.nombre!)
        }
        combo.dataSource = cargosString
        combo.anchorView = sender
        combo.bottomOffset = CGPoint(x: 0, y: (combo.anchorView?.plainView.bounds.height)!)
        combo.show()
        combo.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            cargoFiltro = item
        }
        
    }
    
    @IBAction func btnBuscar(_ sender: Any) {
    }
    
    @IBAction func vistaCrearEmpleado(_ sender: Any) {
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
