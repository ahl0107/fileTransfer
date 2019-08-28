//
//  CommonView.swift
//  FileTransfer
//
//  Created by 李爱红 on 2019/8/28.
//  Copyright © 2019 elastos. All rights reserved.
//

import UIKit

class CommonView: UIView {


    var title: UILabel!
    var textFile: UITextField!
    var button: UIButton!
    var row: UIImageView!
    var subTitle: UILabel!
    var state: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        creatUI()
        self.backgroundColor = ColorHex("#76d4f8")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI() {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        title = UILabel()
        self.addSubview(title)

        textFile = UITextField()
        textFile.isEnabled = false
        self.addSubview(textFile)
        row = UIImageView()
        self.addSubview(row)
        subTitle = UILabel()
        subTitle.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(subTitle)
        state = UILabel()
        state.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(state)

        button = UIButton()
        self.addSubview(button)

        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(60)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(44)
        }

        textFile.snp.makeConstraints { make in
            make.left.equalTo(title.snp_right).offset(5)
            make.top.equalTo(title)
            make.right.equalTo(row.snp_left).offset(-5)
            make.height.equalTo(title)
        }

        row.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalTo(textFile)
            make.height.equalTo(14)
            make.width.equalTo(14)
        }

        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp_bottom).offset(5)
            make.left.equalTo(title)
            make.height.equalTo(22)
            make.width.equalTo(title)
        }

        state.snp.makeConstraints { make in
            make.left.equalTo(textFile)
            make.top.equalTo(subTitle)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(subTitle)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(textFile)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(textFile)
        }
    }

}
