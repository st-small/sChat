//
//  UIImage + Extension.swift
//  sChat
//
//  Created by Stanly Shiyanovskiy on 28.06.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

extension UIImage {
    
    public var scaledToSafeUploadSize: UIImage? {
      let maxImageSideLength: CGFloat = 480
      
      let largerSide: CGFloat = max(size.width, size.height)
      let ratioScale: CGFloat = largerSide > maxImageSideLength ? largerSide / maxImageSideLength : 1
      let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)
      
      return image(scaledTo: newImageSize)
    }
    
    public func image(scaledTo size: CGSize) -> UIImage? {
      defer {
        UIGraphicsEndImageContext()
      }
      
      UIGraphicsBeginImageContextWithOptions(size, true, 0)
      draw(in: CGRect(origin: .zero, size: size))

      return UIGraphicsGetImageFromCurrentImageContext()
    }
}
