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

    //-------------------------------------
    // MARK : - PROPERTIES USED FOR THIS VC
    //-------------------------------------
    
    @IBOutlet weak var layoutOneButton: UIButton!
    @IBOutlet weak var layoutTwoButton: UIButton!
    @IBOutlet weak var layoutThreeButton: UIButton!
    @IBOutlet weak var layoutOneSelectedIcon: UIImageView!
    @IBOutlet weak var layoutTwoSelectedIcon: UIImageView!
    @IBOutlet weak var layoutThreeSelectedIcon: UIImageView!
    
    @IBOutlet weak var pictureView: PictureView!{
        didSet{pictureView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)}
    }
    
    
    var screenOrientation: ScreenOrientation = .portrait
    
    var buttonClicked: ButtonClicked = .none
    
    var layoutButtonSelected: LayoutButtonSelected = .layoutButtonOne
    
    //------------------------------
    // MARK : - OVERRIDDEN FUNCTIONS
    //------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureView.setLayoutOne()
        showCheckMark(layoutOneSelectedIcon)
        hideOtherCheckMarks(layoutTwoSelectedIcon, layoutThreeSelectedIcon)
        resetLayoutOne()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragPictureView(_:)))
        pictureView.addGestureRecognizer(panGestureRecognizer)
    }
    
    // to detect the orientation of the screen
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            keepTheGoodLayoutButtonChecked()
            screenOrientation = .landscape
        } else {
            keepTheGoodLayoutButtonChecked()
            screenOrientation = .portrait
        }
    }
    
    //------------------------------------------
    // MARK : - MANAGEMENT OF THE LAYOUT BUTTONS
    //------------------------------------------
    
    func keepTheGoodLayoutButtonChecked(){
        switch layoutButtonSelected{
        case .layoutButtonOne:
            showCheckMark(layoutOneSelectedIcon)
            hideOtherCheckMarks(layoutTwoSelectedIcon, layoutThreeSelectedIcon)
        case .layoutButtonTwo:
            showCheckMark(layoutTwoSelectedIcon)
            hideOtherCheckMarks(layoutOneSelectedIcon, layoutThreeSelectedIcon)
        case .layoutButtonThree:
            showCheckMark(layoutThreeSelectedIcon)
            hideOtherCheckMarks(layoutOneSelectedIcon, layoutTwoSelectedIcon)
        }
    }
    
    @IBAction func didTapLayoutOneButton(_ sender: Any) {
        resetLayoutOne()
        layoutButtonSelected = .layoutButtonOne
        pictureView.setLayoutOne()
        keepTheGoodLayoutButtonChecked()
    }
    
    @IBAction func didTapLayoutTwoButton(_ sender: Any) {
        resetLayoutTwo()
        layoutButtonSelected = .layoutButtonTwo
        pictureView.setLayoutTwo()
        keepTheGoodLayoutButtonChecked()
    }
    
    @IBAction func didTapLayoutThreeButton(_ sender: Any) {
        resetLayoutThree()
        layoutButtonSelected = .layoutButtonThree
        pictureView.setLayoutThree()
        keepTheGoodLayoutButtonChecked()
    }
    
    // Function to reset the different layouts
    
    private func resetLayoutOne() {
        for image in [pictureView.bigImageOne, pictureView.smallImageThree, pictureView.smallImageFour] {
            resetPicture(picture: image!)
        }
    }
    
    private func resetLayoutTwo() {
        for image in [pictureView.bigImageTwo, pictureView.smallImageOne, pictureView.smallImageTwo] {
            resetPicture(picture: image!)
        }
    }
    
    private func resetLayoutThree() {
        for image in [pictureView.smallImageOne, pictureView.smallImageTwo, pictureView.smallImageThree, pictureView.smallImageFour] {
            resetPicture(picture: image!)
        }
    }
    
    // Functions to change the checked image of our layout buttons
    private func hideOtherCheckMarks(_ firstOtherButton: UIImageView, _ secondOtherButton: UIImageView){
        firstOtherButton.isHidden = true
        secondOtherButton.isHidden = true
    }
    
    private func showCheckMark(_ button: UIImageView) {
        button.isHidden = false
    }
    
    //-------------------------------------------
    // TODO : - Finish this function or delete it
    //-------------------------------------------
    // Function to put the cross back on the picture

    private func resetPicture(picture: UIImageView) {
        switch screenOrientation {
        case .landscape:
            picture.image = #imageLiteral(resourceName: "CrossShapeGray")
        case .portrait:
            picture.image = #imageLiteral(resourceName: "CrossShape")
        }
        picture.contentMode = .center
    }
    
    //-----------------------------------------------------
    // MARK : - MANAGEMENT OF THE BUTTONS THAT ADD PICTURES
    //-----------------------------------------------------
    
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
    
    //-------------------------------------------------------------
    // MARK : - MANAGEMENT OF THE PICTURE SOURCE & THE ACTION SHEET
    //-------------------------------------------------------------
    
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
    
    //----------------------------------------------------------------
    // MARK : - MANAGEMENT OF THE PICTURE PICKER TO SET UP THE PICTURE
    //----------------------------------------------------------------
    
    // Delegate for the picker controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        switch buttonClicked {
        case .smallButtonOne:
            pictureView.smallImageOne.contentMode = .scaleAspectFill
            pictureView.smallImageOnePicked = image
        case .smallButtonTwo:
            pictureView.smallImageTwo.contentMode = .scaleAspectFill
            pictureView.smallImageTwoPicked = image
        case .smallButtonThree:
            pictureView.smallImageThree.contentMode = .scaleAspectFill
            pictureView.smallImageThreePicked = image
        case .smallButtonFour:
            pictureView.smallImageFour.contentMode = .scaleAspectFill
            pictureView.smallImageFourPicked = image
        case .bigButtonOne:
            pictureView.bigImageOne.contentMode = .scaleAspectFill
            pictureView.bigImageOnePicked = image
        case .bigButtonTwo:
            pictureView.bigImageTwo.contentMode = .scaleAspectFill
            pictureView.bigImageTwoPicked = image
        case .none:
            break 
        }
        dismiss(animated:true, completion: nil)
    }
    
    //---------------------------------------------------------------------
    // MARK : - MANAGEMENT OF THE PICTURE SWIPE GESTURE AND SHARING OPTIONS
    //---------------------------------------------------------------------
    
    
    //Function to recognize the gesture A MODIFIER
    @objc func dragPictureView(_ sender: UIPanGestureRecognizer){
        switch sender.state {
        case .changed :
            sharePictureGesture()
            openTheSharingSheetPictureViewIntoAnImage()
        default:
            break
        }
    }
    
    // Function to share the picture once it's finished
    private func sharePictureGesture() {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        switch screenOrientation {
        case .landscape:
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        case .portrait:
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pictureView.transform = translationTransform
        }) { (success) in
            if success {
                self.putThePictureViewBack()
            }
        }
    }
    
    private func putThePictureViewBack() {
        var translationTransform: CGAffineTransform
        switch screenOrientation {
        case .landscape:
            translationTransform = .identity
        case .portrait:
            translationTransform = .identity
        }
        UIView.animate(withDuration: 2, animations: {
            self.pictureView.transform = translationTransform}) {
                (success) in if success {
                self.resetLayoutOne()
                self.resetLayoutTwo()
                self.resetLayoutThree()
            }
        }
    }
    
    private func openTheSharingSheetPictureViewIntoAnImage() {
        let imageToBeSaved = pictureView.asImage()
        let activityItem: [AnyObject] = [imageToBeSaved as AnyObject]
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        self.present(avc, animated: true)
    }
    

}




