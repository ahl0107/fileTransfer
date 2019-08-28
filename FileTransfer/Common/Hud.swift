//
//  HiveHud.swift
//  HyPort
//
//  Created by 李爱红 on 2019/8/14.
//  Copyright © 2019 elastos. All rights reserved.
//

import UIKit

class Hud: UIView {
    static var hud: MBProgressHUD?
    class func show(_ view: UIView, _ title: String, _ after: TimeInterval) {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud!.mode = .text
        hud!.label.text = title
        hud!.hide(animated: true, afterDelay: after)

    }

}
