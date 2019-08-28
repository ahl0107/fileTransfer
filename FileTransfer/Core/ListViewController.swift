//
//  ListViewController.swift
//  FileTransfer
//
//  Created by 李爱红 on 2019/8/28.
//  Copyright © 2019 elastos. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mainTableView: UITableView!
    var dataSource: Array<CarrierFriendInfo> = []
    var currentGroup: CarrierGroup!
    typealias Closure = (CarrierFriendInfo) -> Void
    var closure: Closure!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        creatUI()
        let item=UIBarButtonItem(title: "确定", style: UIBarButtonItem.Style.plain, target: self, action: #selector(sureAction))
        item.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = item
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard DeviceManager.sharedInstance.carrierInst.isReady() else {
            Hud.show(self.view, "Is not ready", 0.5)
            return
        }
        do {
            try dataSource = DeviceManager.sharedInstance.carrierInst.getFriends()
            mainTableView.reloadData()
        } catch {
            print(error)
            Hud.show(self.view, error as! String, 0.5)
        }
    }

    func creatUI() {
        mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 55
        mainTableView.separatorStyle = .none
        mainTableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        mainTableView.allowsMultipleSelection = true
        self.view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()

            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.bottom.equalToSuperview().offset(-49)
            }
        }
    }

    //    MARK: - closure send values methods -
    func callBack(_ closure: @escaping Closure) {
        self.closure = closure
    }

    @objc func sureAction() {
        var selectIndexs = [Int]()
        if let selectItem = mainTableView.indexPathsForSelectedRows {
            for indexPath in selectItem {
                selectIndexs.append(indexPath.row)
            }
        }
        for index in selectIndexs {
            let friend: CarrierFriendInfo = dataSource[index]
            if let closure = self.closure {
                closure(friend)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        cell.model = dataSource[indexPath.row]
        if tableView.indexPathsForSelectedRows?.firstIndex(of: indexPath) != nil {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView)
        let cell = mainTableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = mainTableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
