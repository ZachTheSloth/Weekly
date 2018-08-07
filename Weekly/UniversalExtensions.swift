//
//  UniversalExtensions.swift
//  Weekly
//
//  Created by Zachary Williams on 8/7/18.
//  Copyright © 2018 Zachary Williams. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func setImageColor(color: UIColor)
    {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
