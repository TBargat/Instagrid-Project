//
//  PictureView.swift
//  Instagrid
//
//  Created by Thibault Dev on 03/07/2018.
//  Copyright © 2018 Thibault Dev. All rights reserved.
//

import UIKit

class PictureView: UIView {

    //---------------------------------------
    // MARK : - PROPERTIES USED FOR THIS VIEW
    //---------------------------------------
    
    @IBOutlet private var smallFrameOne: UIView!{
        didSet{makeRoundCorners(frame: smallFrameOne)}
    }
    @IBOutlet private var smallFrameTwo: UIView!
        {didSet{makeRoundCorners(frame: smallFrameTwo)}
    }
    @IBOutlet private var smallFrameThree: UIView!{
        didSet{makeRoundCorners(frame: smallFrameThree)}
    }
    @IBOutlet private var smallFrameFour: UIView!{
        didSet{makeRoundCorners(frame: smallFrameFour)}
    }
    @IBOutlet private var bigFrameOne: UIView!{
        didSet{makeRoundCorners(frame: bigFrameOne)}
    }
    @IBOutlet private var bigFrameTwo: UIView!{
        didSet{makeRoundCorners(frame: bigFrameTwo)}
    }

    @IBOutlet var smallImageOne: UIImageView!
    @IBOutlet var smallImageTwo: UIImageView!
    @IBOutlet var smallImageThree: UIImageView!
    @IBOutlet var smallImageFour: UIImageView!
    @IBOutlet var bigImageOne: UIImageView!
    @IBOutlet var bigImageTwo: UIImageView!
    
    var smallImageOnePicked = UIImage() {
        didSet {smallImageOne.image = smallImageOnePicked}
    }
    
    var smallImageTwoPicked = UIImage() {
        didSet {smallImageTwo.image = smallImageTwoPicked}
    }
    
    var smallImageThreePicked = UIImage() {
        didSet {smallImageThree.image = smallImageThreePicked}
    }
    
    var smallImageFourPicked = UIImage() {
        didSet {smallImageFour.image = smallImageFourPicked}
    }
    
    var bigImageOnePicked = UIImage() {
        didSet {bigImageOne.image = bigImageOnePicked}
    }
    
    var bigImageTwoPicked = UIImage() {
        didSet{bigImageTwo.image = bigImageTwoPicked}
    }
   
    
    //-----------------------------------------
    // MARK : - METHODS TO GET THE GOOD LAYOUTS
    //-----------------------------------------
    
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
    
    //---------------------------------------------------------
    // MARK : - FUNCTION USED TO ROUND THE CORNERS OF THE TILES
    //---------------------------------------------------------
    
    private func makeRoundCorners(frame : UIView){
        frame.layer.cornerRadius = 2
        frame.layer.masksToBounds = true
    }
}
