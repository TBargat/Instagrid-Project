//
//  File.swift
//  Instagrid
//
//  Created by Thibault Dev on 31/07/2018.
//  Copyright © 2018 Thibault Dev. All rights reserved.
//

import Foundation

import UIKit

// Class to check if a picture is loaded or not

class CanvasFilling {
    func checkIfThereIsAPhotoOnThePicture(picture: UIImageView) -> Bool{
        var photoOnPicture = false
        if picture.image != #imageLiteral(resourceName: "CrossShape") {
            photoOnPicture = true
        } else {
            photoOnPicture = false
        }
        return photoOnPicture
    }
}
