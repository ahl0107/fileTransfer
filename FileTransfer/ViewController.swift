//
//  ViewController.swift
//  FileTransfer
//
//  Created by 李爱红 on 2019/8/28.
//  Copyright © 2019 elastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var qrcodeView: UIImageView!
    var friendView: CommonView!
    var fileView: CommonView!
    var transfile: CommonView!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        loadMyInfo()
    }

    func creatUI() {

        friendView = CommonView()
        friendView.title.text = "Friend"
        friendView.textFile.placeholder = "Please selected friend."
        friendView.subTitle.text = "State"
        
        fileView = CommonView()
        fileView.title.text = "File"
        fileView.subTitle.text = "State"
        fileView.textFile.placeholder = "Please selected file."
        transfile = CommonView()
        transfile.title.text = ""
        transfile.button.setTitle("TransferFile", for: .normal)
        transfile.button.backgroundColor = UIColor.lightGray
        transfile.button.layer.cornerRadius = 5.0
        transfile.button.layer.masksToBounds = true

        stackView = UIStackView(arrangedSubviews: [friendView, fileView, transfile])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 12
        stackView.layer.cornerRadius = 5.0
        stackView.clipsToBounds = true
        self.view.addSubview(stackView)

        qrcodeView = UIImageView()
        qrcodeView.backgroundColor = UIColor.red
        self.view.addSubview(qrcodeView)
        qrcodeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(88)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(qrcodeView.snp_bottom).offset(24)
            make.height.equalTo(120 * 3)
        }
    }

    func loadMyInfo() {
        if let carrierInst = DeviceManager.sharedInstance.carrierInst {
            if (try? carrierInst.getSelfUserInfo()) != nil {
                let address = carrierInst.getAddress()
                let qrCode = QRCode(address)
                qrcodeView!.image = qrCode?.image
                return
            }
        }
    }

}

