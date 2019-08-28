//
//  ListCell.swift
//  FileTransfer
//
//  Created by 李爱红 on 2019/8/28.
//  Copyright © 2019 elastos. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    var icon: UIImageView!
    var nameLable: UILabel!
    var model: CarrierFriendInfo?{
        didSet{
            nameLable.text = model?.name
            if model!.name == nil || model!.name == "" {
                nameLable.text = model?.userId
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI() -> Void {

        icon = UIImageView.init(image: UIImage(named: "remote")!)
        self.contentView.addSubview(icon!)

        nameLable = UILabel()
        nameLable.backgroundColor = UIColor.clear
        nameLable.text = ""
        nameLable.textAlignment = .left
        nameLable.sizeToFit()
        self.contentView.addSubview(nameLable)

        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(line)

        icon.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(33)
            make.centerY.equalToSuperview()
        })

        nameLable.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon!.snp_right).offset(12)
            make.right.equalToSuperview().offset(-40)
            make.height.equalToSuperview()
        })

        line.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview()
        }
    }

}
