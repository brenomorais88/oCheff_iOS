//
//  HistoricDetailHeaderCell.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (RARO SERVICOS DE INFORMATICA LTDA – 026 – SP) on 19/02/23.
//

import UIKit

class HistoricDetailHeaderCell: UITableViewCell {
    static let cellID = "HistoricDetailHeaderCell"
    
    @IBOutlet weak var ticketView: UIView?
    @IBOutlet weak var ticketImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageColor()
    }
    
    func setupImageColor() {
//        guard let viewPoint = ticketView?.getCenterCGPoint() else { return }
//        let imageColor: UIColor = ticketView?.layer.colorOfPoint(point: viewPoint) ?? UIColor.red
//        ticketImage?.setImageColor(color: imageColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//extension UIImageView {
//  func setImageColor(color: UIColor) {
//    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
//    self.image = templateImage
//    self.tintColor = color
//  }
//}
//
//extension CALayer {
//
//    func colorOfPoint(point: CGPoint) -> UIColor {
//
//        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
//
//        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
//
//        context!.translateBy(x: -point.x, y: -point.y)
//
//        self.render(in: context!)
//
//        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
//        let green: CGFloat = CGFloat(pixel[1]) / 255.0
//        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
//        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
//
//        let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)
//
//        return color
//    }
//}
//
//extension UIView {
//    func getCenterCGPoint() -> CGPoint {
//        let centerX = self.frame.origin.x
//        let centerY = self.frame.origin.y
//
//        return CGPoint(x: centerX,
//                       y: centerY)
//    }
//}
