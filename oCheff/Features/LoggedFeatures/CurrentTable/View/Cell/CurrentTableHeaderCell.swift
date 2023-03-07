//
//  CurrentTableHeaderCell.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 24/02/23.
//

import UIKit

protocol CurrentTableHeaderCellProtocol {
    func openMenu()
    func callWaiter()
}

class CurrentTableHeaderCell: UITableViewCell {
    static let cellID = "CurrentTableHeaderCell"
    var delegate: CurrentTableHeaderCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(delegate: CurrentTableHeaderCellProtocol) {
        self.delegate = delegate
    }
    
    //MARK: actions
    
    @IBAction func callWaiter(_ sender: Any) {
        self.delegate?.callWaiter()
    }
    
    @IBAction func openMenu(_ sender: Any) {
        self.delegate?.openMenu()
    }
}
