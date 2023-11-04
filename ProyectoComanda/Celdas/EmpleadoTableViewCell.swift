//
//  EmpleadoTableViewCell.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit

class EmpleadoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblCargo: UILabel!
    @IBOutlet weak var lblDNI: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
