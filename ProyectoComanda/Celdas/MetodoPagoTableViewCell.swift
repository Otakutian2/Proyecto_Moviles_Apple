//
//  MetodoPagoTableViewCell.swift
//  ProyectoComanda
//
//  Created by Gary on 23/10/23.
//

import UIKit

class MetodoPagoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCodigo: UILabel!
    
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
