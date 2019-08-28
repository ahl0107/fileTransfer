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
    }

    func creatUI() {

        friendView = CommonView()
        friendView.title.text = "friend"
        friendView.textFile.placeholder = "please selected friend."
        friendView.subTitle.text = "state"
        fileView = CommonView()
        fileView.title.text = "File"
        fileView.subTitle.text = "state"
        fileView.textFile.placeholder = "please selected file."
        transfile = CommonView()
        transfile.title.text = ""
        transfile.button.setTitle("TransferFile", for: .normal)

        stackView = UIStackView(arrangedSubviews: [friendView, fileView, transfile])
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.fill
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 5
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
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(qrcodeView.snp_bottom).offset(24)
            make.height.equalTo(100 * 3)
        }
    }


}

