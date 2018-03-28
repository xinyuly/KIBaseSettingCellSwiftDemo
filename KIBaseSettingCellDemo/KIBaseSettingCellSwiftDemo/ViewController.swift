//
//  ViewController.swift
//  KIBaseSettingCellSwiftDemo
//
//  Created by xinyu on 2018/3/12.
//  Copyright © 2018年 MaChat. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,KIBaseSettingTableViewCellDelegate {
    var tableView :UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
        tableView = UITableView.init()
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        tableView?.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView?.separatorStyle = .none
        tableView?.register(RCDGroupSettingsTableViewCell.self, forCellReuseIdentifier: "RCDGroupSettingsTableViewCell")
    }
    
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = RCDGroupSettingsTableViewCell.init(indexPath: indexPath as NSIndexPath)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //MARK: - KIBaseSettingTableViewCellDelegate
    func onClickSwitchButton(sender: UISwitch) {
        print(sender.isOn ? "开" : "关")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

