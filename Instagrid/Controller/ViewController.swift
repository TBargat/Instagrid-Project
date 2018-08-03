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

    // MARK : - PROPERTIES USED FOR THIS VC
    
    @IBOutlet weak var layoutOneButton: UIButton!
    @IBOutlet weak var layoutTwoButton: UIButton!
    @IBOutlet weak var layoutThreeButton: UIButton!
    @IBOutlet weak var layoutOneSelectedIcon: UIImageView!
    @IBOutlet weak var layoutTwoSelectedIcon: UIImageView!
    @IBOutlet weak var layoutThreeSelectedIcon: UIImageView!
    
    @IBOutlet weak var pictureView: PictureView!{
        didSet{pictureView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)}
    }
    
    // To know which rules to apply to the swipe gesture
    var screenOrientation: ScreenOrientation = .portrait
    
    // To know wich frame was clicked on the canvas
    var buttonClicked: ButtonClicked = .none
    
    // To know which layout is currently set
    var layoutButtonSelected: LayoutButtonSelected = .layoutButtonOne
    
    var canvasFilling = CanvasFilling()
    
    // MARK : - OVERRIDDEN FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureView.setLayoutOne()
        showCheckMark(layoutOneSelectedIcon)
        hideOtherCheckMarks(layoutTwoSelectedIcon, layoutThreeSelectedIcon)
        resetLayoutOne()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragPictureView(_:)))
        pictureView.addGestureRecognizer(panGestureRecognizer)
    }
    
    // To detect the orientation of the screen
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
    
    // MARK : - MANAGEMENT OF THE LAYOUT BUTTONS
    
    // Method to ensure that we keep the good checkmark even after a rotation
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
    
    // Method to reset the different layouts
    
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
    
    // Methods to change the checked image of our layout buttons
    
    private func hideOtherCheckMarks(_ firstOtherButton: UIImageView, _ secondOtherButton: UIImageView){
        firstOtherButton.isHidden = true
        secondOtherButton.isHidden = true
    }
    
    private func showCheckMark(_ button: UIImageView) {
        button.isHidden = false
    }
    
    // MARK : - METHOD TO RESET ANY PICTURE

    private func resetPicture(picture: UIImageView) {
        picture.image = #imageLiteral(resourceName: "CrossShape")
        picture.contentMode = .center
    }
    
    // MARK : - MANAGEMENT OF THE BUTTONS THAT ADD PICTURES
    
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
    
    // MARK : - MANAGEMENT OF THE PICTURE SOURCE & THE ACTION SHEET
    
    // Method to access the Photo Library
    private func accessPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.modalPresentationStyle = .overCurrentContext
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Method to Access the Camera (only works with a real device)
    private func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Method to display our Action Sheet
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
    
    // MARK : - MANAGEMENT OF THE PICTURE PICKER TO SET UP THE PICTURE
    
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
    
    // MARK : - MANAGEMENT OF THE PICTURE SWIPE GESTURE AND SHARING OPTIONS
    
    
    // Method to recognize the gesture an launch the sharing process
    
    @objc func dragPictureView(_ sender: UIPanGestureRecognizer){
        if pictureViewIsFull() == true {
            switch sender.state {
            case .changed :
                sharePictureGesture()
                openTheSharingSheetPictureViewIntoAnImage()
            default:
                break
            }
        } else {
           messageToTheUser()
        }
    }
    
    // Method to share the picture once the canvas is full
    
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
        UIView.animate(withDuration: 0.3, animations: {
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
    

    // MARK : - METHOD TO CHECK IF OUR PICTURE VIEW IS FULL
    
    private func pictureViewIsFull() -> Bool {
        var fullFilling = false
        switch layoutButtonSelected{
        case .layoutButtonOne:
            fullFilling = layoutOneFull()
        case .layoutButtonTwo:
            fullFilling = layoutTwoFull()
        case .layoutButtonThree:
            fullFilling = layoutThreeFull()
        }
        return fullFilling
    }
    
    private func layoutOneFull() -> Bool {
        if [canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.bigImageOne),
            canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageThree),
            canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageFour)] == [true, true, true]{
            return true
        } else { return false}
    }
    
    private func layoutTwoFull() -> Bool {
        if [canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.bigImageTwo),
            canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageOne),
            canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageTwo)] == [true, true, true]{
            return true
        } else { return false}
    }
    
    private func layoutThreeFull() -> Bool {
        if [canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageOne),
            canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageTwo),
            canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageThree),
            canvasFilling.checkIfThereIsAPhotoOnThePicture(picture: pictureView.smallImageFour)] == [true, true, true, true]{
            return true
        } else { return false}
    }
    
    // MARK : - MESSAGE FOR THE USERS TO MAKE THEM FILL THE CANVAS
    
    private func messageToTheUser() {
        let alert = UIAlertController(title: "Pas si vite!", message: "Il faut remplir tous les espaces avant de pouvoir exporter votre création.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok, je vais terminer mon oeuvre!", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}




