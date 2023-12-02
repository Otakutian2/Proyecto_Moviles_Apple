//
//  CajaRegistradoraTableViewCell.swift
//  ProyectoComanda
//
//  Created by Sebastian on 1/12/23.
//

import UIKit

class CajaRegistradoraTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblIdComprobante: UILabel!
    
    @IBOutlet weak var lblFechaEmison: UILabel!
    
    @IBOutlet weak var lblMetodoPago: UILabel!
    
    @IBOutlet weak var lblCaja: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
