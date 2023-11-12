//
//  MesaTableViewCell.swift
//  ProyectoComanda
//
//  Created by Gary on 4/11/23.
//

import UIKit

class MesaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAsientos: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var lblCodigo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
