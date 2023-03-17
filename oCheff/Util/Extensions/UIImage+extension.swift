//
//  UIImage+extension.swift
//  oCheff
//
//  Created by Breno Morais on 15/03/23.
//

import UIKit

extension UIImage {
    
    func toBase64String() -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    static func base64StringToImage(string: String) -> UIImage? {
        if let imageData = Data(base64Encoded: string) {
            let image = UIImage(data: imageData)
            return image
        }
        return nil
    }
}
