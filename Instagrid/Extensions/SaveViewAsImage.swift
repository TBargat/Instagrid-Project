//
//  SaveViewAsImage.swift
//  Instagrid
//
//  Created by Thibault Dev on 26/07/2018.
//  Copyright © 2018 Thibault Dev. All rights reserved.
//

import Foundation

import UIKit

// Extension to turn a View into an Image

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { (context) in
            layer.render(in: context.cgContext)
        }
    }
}
