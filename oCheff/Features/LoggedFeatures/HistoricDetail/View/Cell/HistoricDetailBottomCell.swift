//
//  HistoricDetailBottomCell.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import UIKit

class HistoricDetailBottomCell: UITableViewCell {
    static let cellID = "HistoricDetailBottomCell"
    
    @IBOutlet weak var grayView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    func setupLayout() {
        let width: CGFloat = UIScreen.main.bounds.width - 48
        let height: CGFloat = 115
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        grayView?.roundBottom(bounds: bounds)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
