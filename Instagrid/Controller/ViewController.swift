//
//  ViewController.swift
//  Instagrid
//
//  Created by Thibault Dev on 02/07/2018.
//  Copyright © 2018 Thibault Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var layoutOneButton: UIButton!
    @IBOutlet weak var layoutTwoButton: UIButton!
    @IBOutlet weak var layoutThreeButton: UIButton!
    
    @IBOutlet weak var pictureView: PictureView!
    
    @IBAction func didTapLayoutOneButton(_ sender: Any) {
        pictureView.setLayoutOne()
        showCheckMark(layoutOneButton)
        hideOtherCheckMarks(layoutTwoButton, layoutThreeButton)
        
    }
    @IBAction func didTapLayoutTwoButton(_ sender: Any) {
        pictureView.setLayoutTwo()
        showCheckMark(layoutTwoButton)
        hideOtherCheckMarks(layoutOneButton, layoutThreeButton)
    }
    @IBAction func didTapLayoutThreeButton(_ sender: Any) {
        pictureView.setLayoutThree()
        showCheckMark(layoutThreeButton)
        hideOtherCheckMarks(layoutOneButton, layoutTwoButton)
    }
    
    // Functions to change the checked image of our layout buttons
    
    private func hideOtherCheckMarks(_ firstOtherButton: UIButton, _ secondOtherButton: UIButton){
        firstOtherButton.imageView?.isHidden = true
        secondOtherButton.imageView?.isHidden = true
    }
    
    private func showCheckMark(_ button: UIButton) {
        button.imageView?.isHidden = false
    }
    
    

}

