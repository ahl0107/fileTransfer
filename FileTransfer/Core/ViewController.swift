//
//  ViewController.swift
//  FileTransfer
//
//  Created by 李爱红 on 2019/8/28.
//  Copyright © 2019 elastos. All rights reserved.
//

import UIKit

var transferFrientId = ""
var friendState = ""
class ViewController: UIViewController {

    var qrcodeView: UIImageView!
    var friendView: CommonView!
    var fileView: CommonView!
    var transfile: CommonView!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        creatBarItem()
        loadMyInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendStatusChanged(notif:)), name: .friendStatusChanged, object: nil)
    }

    func creatBarItem() {
       let item = UIBarButtonItem(title: "添加", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addDevice))
        item.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = item
    }

    func creatUI() {

        friendView = CommonView()
        friendView.title.text = "Friend"
        friendView.textFile.placeholder = "Please selected friend."
        friendView.row.image = UIImage(named: "row")
        friendView.button.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
        friendView.subTitle.text = "State"
        
        fileView = CommonView()
        fileView.title.text = "File"
        fileView.subTitle.text = "State"
        fileView.row.image = UIImage(named: "row")
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
        self.view.addSubview(stackView)

        qrcodeView = UIImageView()
        qrcodeView.backgroundColor = UIColor.red
        self.view.addSubview(qrcodeView)
        qrcodeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(120)
        }
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(qrcodeView.snp_bottom).offset(24)
            make.height.equalTo(100 * 3)
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

    func refresh(_ status: CarrierConnectionStatus) {
        if status == CarrierConnectionStatus.Connected {
            self.friendView.state.text = "Online"
            self.friendView.state.textColor = UIColor.green
        }else {
            self.friendView.state.textColor = UIColor.lightGray
            self.friendView.state.text = "Offline"
        }
    }

    //    MARK: action
    @objc func addDevice() {
        let scanVC = ScanViewController();
        self.navigationController?.show(scanVC, sender: nil)
    }

    @objc func showFriends() {
        let listVC = ListViewController()
        listVC.callBack { value in
            transferFrientId = value.userId!
            self.friendView.textFile.text = value.userId!
            self.refresh(value.status)
        }
        self.navigationController?.pushViewController(listVC, animated: true)
    }

    //MARK: - NSNotification -
    @objc func handleFriendStatusChanged(notif: NSNotification) {
        let friendState = notif.userInfo!["friendState"] as! CarrierConnectionStatus
        DispatchQueue.main.sync {
            self.refresh(friendState)
        }
    }
}

