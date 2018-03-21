//
//  RCDGroupSettingsTableViewCell.swift
//  KIBaseSettingCellSwiftDemo
//
//  Created by xinyu on 2018/3/20.
//  Copyright © 2018年 MaChat. All rights reserved.
//

import UIKit

class RCDGroupSettingsTableViewCell: KIBaseSettingTableViewCell {
    
    convenience init(indexPath:NSIndexPath) {
        //右边带图片的cell
        if (indexPath.section == 1 && indexPath.row == 0) {
            self.init(leftImageStr: "", leftImageSize: .zero, rightImageStr: "default_discussion_portrait", rightImageSize: CGSize.init(width: 25, height: 25))
        } else {
            //一般cell
            self.init(style: .default, reuseIdentifier: nil)
        }
        self.initSubviewsWithIndexPath(indexPath: indexPath)
    }
    
    func initSubviewsWithIndexPath(indexPath:NSIndexPath)  {
        if indexPath.section == 0 {
            self.setCellStyle(style: .DefaultStyle)
            self.leftLabel.text = "全部群成员"
        } else if (indexPath.section == 1) {
            switch (indexPath.row) {
            case 0:
                self.setCellStyle(style: .DefaultStyle)
                self.leftLabel.text = "群聊头像"
             break
            case 1:
                self.setCellStyle(style: .DefaultStyle_RightLabel)
                self.leftLabel.text = "群公告"
                self.rightLabel.text = "红包群"
                break
            case 2:
                self.setCellStyle(style: .DefaultStyle)
                self.leftLabel.text = "群公告"
                break;
            case 3:
                self.setCellStyle(style: .DefaultStyle_RightLabel)
                self.leftLabel.text = "我在本群的昵称"
                self.rightLabel.text = "我是XXX"
                break;
            default:
                break;
            }
            
    } else if (indexPath.section == 2) {
             self.setCellStyle(style: .DefaultStyle)
             self.leftLabel.text = "查找聊天记录"
        } else {
            switch (indexPath.row) {
            case 0:
                self.setCellStyle(style: .SwitchStyle)
                self.leftLabel.text = "消息免打扰"
                break;
            case 1:
                 self.setCellStyle(style: .SwitchStyle)
                 self.leftLabel.text = "聊天置顶"
                break;
            case 2:
                 self.setCellStyle(style: .DefaultStyle)
                 self.leftLabel.text = "清除聊天记录"
                break;
            default:
                break;
            }
      }
    }

}
