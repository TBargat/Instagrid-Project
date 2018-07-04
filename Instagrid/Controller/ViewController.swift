//
//  ViewController.swift
//  Instagrid
//
//  Created by Thibault Dev on 02/07/2018.
//  Copyright © 2018 Thibault Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var layoutOneButton: UIButton! {
        didSet {
            layoutOneButton.imageView?.isHidden = false
        }
    }
    @IBOutlet weak var layoutTwoButton: UIButton!{
        didSet {
            layoutTwoButton.imageView?.isHidden = true
        }
    }
    @IBOutlet weak var layoutThreeButton: UIButton!{
        didSet {
            layoutThreeButton.imageView?.isHidden = true
        }
    }
    
    @IBOutlet weak var pictureView: PictureView!{
        didSet{
            pictureView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)
        }
    }
    
    var buttonClicked: ButtonClicked = .none
    
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
    
    // Management of the buttons to add pictures on the canvas
    
    @IBAction func didTapSmallImageOne(_ sender: Any) {
        buttonClicked = .smallButtonOne
        displayActionSheet()
    }
    @IBAction func didTapSmallImageTwo(_ sender: Any) {
        buttonClicked = .smallButtonTwo
        displayActionSheet()
    }
    @IBAction func didTapSmallImageThree(_ sender: Any) {
        buttonClicked = .smallButtonThree
        displayActionSheet()
    }
    @IBAction func didTapSmallImageFour(_ sender: Any) {
        buttonClicked = .smallButtonFour
        displayActionSheet()
    }
    @IBAction func didTapBigImageOne(_ sender: Any) {
        buttonClicked = .bigButtonOne
        displayActionSheet()
    }
    @IBAction func didTapBigImageTwo(_ sender: Any) {
        buttonClicked = .bigButtonTwo
        displayActionSheet()
    }
    
    // Function to reset the frame without any picture
    
    private func resetPictureView() {
    }
    
    // Enum for the button identification
    enum ButtonClicked {
        case none, smallButtonOne, smallButtonTwo, smallButtonThree, smallButtonFour, bigButtonOne, bigButtonTwo
    }
    
    
    // Function Photo Library
    
    private func accessPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    // Function Acces Camera
    
    private func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Function to display our Action Sheet
    private func displayActionSheet() {
        
        let pictureSourceSelector = UIAlertController(title: nil, message: "Choose your picture source" , preferredStyle: .actionSheet)
        
        pictureSourceSelector.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.accessPhotoLibrary()
        }))
        
        pictureSourceSelector.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.accessCamera()
        }))
        
        pictureSourceSelector.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(pictureSourceSelector, animated: true, completion: nil)
        
    }
    
    // Delegate for the picker controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        switch buttonClicked {
        case .smallButtonOne:
            pictureView.smallImageOnePicked = image
        case .smallButtonTwo:
            pictureView.smallImageTwoPicked = image
        case .smallButtonThree:
            pictureView.smallImageThreePicked = image
        case .smallButtonFour:
            pictureView.smallImageFourPicked = image
        case .bigButtonOne:
            pictureView.bigImageOnePicked = image
        case .bigButtonTwo:
            pictureView.bigImageTwoPicked = image
        case .none:
            Void.self // que faire?
        }
        dismiss(animated:true, completion: nil)
    }
    
    // Function to share the picture once it's finished
    
    private func sharePicture() {
        let imageToBeSaved = pictureView.asImage()
        let activityItem: [AnyObject] = [imageToBeSaved as AnyObject]
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }

}

// Extension to turn a View into an Image

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { (context) in
            layer.render(in: context.cgContext)
        }
    }
}

// Extension to have the exact same shadow than on Sketch

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

