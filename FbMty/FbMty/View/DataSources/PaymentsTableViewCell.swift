//
//  PaymentsTableViewCell.swift
//  FbMty
//
//  Created by David Barrera on 6/12/18.
//  Copyright © 2018 HICS SA DE CV. All rights reserved.
//

import UIKit

class PaymentsTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var idDocumentLbl: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}