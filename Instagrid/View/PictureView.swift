//
//  PictureView.swift
//  Instagrid
//
//  Created by Thibault Dev on 03/07/2018.
//  Copyright © 2018 Thibault Dev. All rights reserved.
//

import UIKit

class PictureView: UIView {

    @IBOutlet private var smallFrameOne: UIView!
    @IBOutlet private var smallFrameTwo: UIView!
    @IBOutlet private var smallFrameThree: UIView!
    @IBOutlet private var smallFrameFour: UIView!
    @IBOutlet private var bigFrameOne: UIView!
    @IBOutlet private var bigFrameTwo: UIView!

    @IBOutlet private var smallImageOne: UIImageView!
    @IBOutlet private var smallImageTwo: UIImageView!
    @IBOutlet private var smallImageThree: UIImageView!
    @IBOutlet private var smallImageFour: UIImageView!
    @IBOutlet private var bigImageOne: UIImageView!
    @IBOutlet private var bigImageTwo: UIImageView!
    
    
    // Functions to get the right layout
    
    func setLayoutOne() {
        smallFrameOne.isHidden = true
        smallFrameTwo.isHidden = true
        smallFrameThree.isHidden = false
        smallFrameFour.isHidden = false
        bigFrameOne.isHidden = false
        bigFrameTwo.isHidden = true
        
    }
    
    func setLayoutTwo() {
        smallFrameOne.isHidden = false
        smallFrameTwo.isHidden = false
        smallFrameThree.isHidden = true
        smallFrameFour.isHidden = true
        bigFrameOne.isHidden = true
        bigFrameTwo.isHidden = false
    }
    
    func setLayoutThree() {
        smallFrameOne.isHidden = false
        smallFrameTwo.isHidden = false
        smallFrameThree.isHidden = false
        smallFrameFour.isHidden = false
        bigFrameOne.isHidden = true
        bigFrameTwo.isHidden = true
    }
}
