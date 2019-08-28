//
//  Counst.swift
//  HyPort
//
//  Created by 李爱红 on 2019/8/8.
//  Copyright © 2019 elastos. All rights reserved.
//

import UIKit

/// MARK: Device
let isRetina = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 640, height: 960), (UIScreen.main.currentMode?.size)!) : false)
let iPhone5 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 640, height: 1136), (UIScreen.main.currentMode?.size)!) : false)
let iPhone6 = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 750, height: 1334), (UIScreen.main.currentMode?.size)!) : false)
let iPhone6Plus = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2208), (UIScreen.main.currentMode?.size)!) : false)
let isPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
let isPhone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
let isiPhoneX = (UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), (UIScreen.main.currentMode?.size)!) : false)

//let SAFE_BAR_Height = UIApplication.shared.statusBarFrame.height + 44


/// MARK: UI
let TABBAR_HEIGHT = (isiPhoneX ? 83 : 49)
let NAVIGATION_HEIGHT = (isiPhoneX ? 88 : 64)
var SCREEN_WIDTH: CGFloat {
    get {
        return SCREEN_WIDTH_FUNC()
    }
}
var SCREEN_HEIGHT: CGFloat {
    get {
        return SCREEN_HEIGHT_FUNC()
    }
}

func SCREEN_WIDTH_FUNC() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

func SCREEN_HEIGHT_FUNC() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

/// MARK: color
let COLOR_WHITESMOKE = ColorHex("#F5F5F5")

/// Convert hexadecimal color to UIColor
///
/// - Parameter color: The hexadecimal color
/// - Returns: UIColor
func ColorHex(_ color: String) -> UIColor? {
    if color.count <= 0 || color.count != 7 || color == "(null)" || color == "<null>" {
        return nil
    }
    var red: UInt32 = 0x0
    var green: UInt32 = 0x0
    var blue: UInt32 = 0x0
    let redString = String(color[color.index(color.startIndex, offsetBy: 1)...color.index(color.startIndex, offsetBy: 2)])
    let greenString = String(color[color.index(color.startIndex, offsetBy: 3)...color.index(color.startIndex, offsetBy: 4)])
    let blueString = String(color[color.index(color.startIndex, offsetBy: 5)...color.index(color.startIndex, offsetBy: 6)])
    Scanner(string: redString).scanHexInt32(&red)
    Scanner(string: greenString).scanHexInt32(&green)
    Scanner(string: blueString).scanHexInt32(&blue)
    let hexColor = UIColor.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    return hexColor
}

/// add mask
func addShadowToView(_ view: UIView, color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
    view.layer.shadowColor = color.cgColor
    view.layer.shadowOffset = offset
    view.layer.shadowOpacity = opacity
    view.layer.shadowRadius = radius
}

/// Calculate the width of the layer
func width(_ object: UIView) -> CGFloat {
    return object.frame.width
}

/// X coordinates in main view
func minX(_ object: UIView) -> CGFloat {
    return object.frame.origin.x
}

/// 在父视图中的x坐标+自身宽度
func maxX(_ object: UIView) -> CGFloat {
    return object.frame.origin.x+width(object)
}

/// 在父视图中的y坐标
func minY(_ object: UIView) -> CGFloat {
    return object.frame.origin.y
}

/// 在父视图中的y坐标+自身高度
func maxY(_ object: UIView) -> CGFloat {
    return object.frame.origin.y+height(object)
}

/// 计算图层的高度
func height(_ object: UIView) -> CGFloat {
    return object.frame.height
}
