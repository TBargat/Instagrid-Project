//
//  EnumsUsedInTheViewController.swift
//  Instagrid
//
//  Created by Thibault Dev on 26/07/2018.
//  Copyright © 2018 Thibault Dev. All rights reserved.
//

import Foundation

import UIKit

//---------------------------------------
// MARK : - CANVAS BUTTONS IDENTIFICATION
//---------------------------------------
enum ButtonClicked {
    case none, smallButtonOne, smallButtonTwo, smallButtonThree, smallButtonFour, bigButtonOne, bigButtonTwo
}

//-------------------------------------------
// MARK : - SCREEN ORIENTATION IDENTIFICATION
//-------------------------------------------

enum ScreenOrientation {
    case portrait, landscape
}

///--------------------------------------
// MARK : - LAYOUT BUTTONS IDENTIFICATION
//---------------------------------------

enum LayoutButtonSelected{
    case layoutButtonOne, layoutButtonTwo, layoutButtonThree
}
