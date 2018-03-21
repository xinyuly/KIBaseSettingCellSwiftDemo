//
//  KIBaseSettingTableViewCell.swift
//  KIBaseSettingCellSwiftDemo
//
//  Created by xinyu on 2018/3/12.
//  Copyright © 2018年 MaChat. All rights reserved.
//

import UIKit

enum KIBaseSettingCellStyle : Int {
    case DefaultStyle = 0
    case DefaultStyle_RightLabel_WithoutRightArrow = 1
    case DefaultStyle_RightLabel = 2
    case SwitchStyle = 3
    case OnlyDisplayLeftLabelStyle = 4
}

protocol KIBaseSettingTableViewCellDelegate : NSObjectProtocol {
    func onClickSwitchButton(sender:UISwitch)
}

class KIBaseSettingTableViewCell: UITableViewCell {
    var leftImageView : UIImageView?
    var leftLabel = UILabel(frame: CGRect.zero)
    var rightLabel = UILabel(frame: CGRect.zero)
    var switchButton : UISwitch?
    var rightImageView : UIImageView?
    var rightArrow : UIImageView?
    var bottomLine : UIView?
    var switchButtonStatus = false
    var leftLabelConstraints: NSArray?
    var cellSubViews : NSDictionary?
    var rightLabelConstraints :NSArray?
    var delegate:KIBaseSettingTableViewCellDelegate?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
         initialize()
    }

    convenience init(leftImageStr:String,leftImageSize:CGSize,rightImageStr:String,rightImageSize:CGSize) {
        self.init(style: .default, reuseIdentifier: nil)
        if leftImageStr.count > 0 {
            self.leftImageView = UIImageView.init()
            self.leftImageView?.contentMode = .scaleAspectFill
            self.leftImageView?.clipsToBounds = true
            self.setupImageView(imageView: self.leftImageView!, imageStr: leftImageStr, imageSize: leftImageSize, LeftOrRight: 0)
        }
        
        if rightImageStr.count > 0 {
            self.rightImageView = UIImageView.init()
            self.rightImageView?.contentMode = .scaleAspectFill
            self.rightImageView?.clipsToBounds = true
            self.setupImageView(imageView: self.rightImageView!, imageStr: rightImageStr, imageSize: rightImageSize, LeftOrRight: 1)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize()  {
        self.leftLabel = UILabel.init()
        self.leftLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.leftLabel.textColor = UIColor.black
        self.leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.rightLabel = UILabel.init()
        self.rightLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.rightLabel.textColor = UIColor.lightText
        self.rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.rightArrow = UIImageView.init()
        self.rightArrow?.image = UIImage.init(named: "right_arrow")
        self.rightArrow?.translatesAutoresizingMaskIntoConstraints = false
        
        self.switchButton = UISwitch.init()
        self.switchButton?.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControlEvents.valueChanged)
        self.switchButton?.isOn = self.switchButtonStatus
        self.switchButton?.translatesAutoresizingMaskIntoConstraints = false
        
        self.bottomLine = UIView.init()
        self.bottomLine?.backgroundColor = UIColor.lightGray
        self.bottomLine?.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.leftLabel)
        self.contentView.addSubview(self.rightLabel)
        self.contentView.addSubview(self.rightArrow!)
        self.contentView.addSubview(self.switchButton!)
        self.contentView.addSubview(self.bottomLine!)
        
        self.cellSubViews = ["leftLabel":leftLabel,"rightLabel":rightLabel,"rightArrow":rightArrow ?? UIImageView.init(frame: .zero) ,"switchButton":switchButton ?? UISwitch.init(frame: .zero),"bottomLine":bottomLine ?? UIView.init(frame: .zero)]
        self.setLayout()
        
    }
    
    @objc func onClickSwitch(sender:UISwitch) {
        if (delegate) != nil {
            delegate?.onClickSwitchButton(sender: sender)
        }
    }
    
    func setLayout() {
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[leftLabel(21)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: self.cellSubViews as! [String : Any]))
        
        self.contentView.addConstraint(NSLayoutConstraint.init(item: leftLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[rightLabel(21)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: self.cellSubViews as! [String : Any]))
        
        self.contentView.addConstraint(NSLayoutConstraint.init(item: rightLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[rightArrow(13)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: self.cellSubViews as! [String : Any]))
        
        self.contentView.addConstraint(NSLayoutConstraint.init(item: rightArrow ?? UIImageView.init(frame: .zero), attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[bottomLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: self.cellSubViews as! [String : Any]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomLine(0.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: self.cellSubViews as! [String : Any]))
        self.contentView.addConstraint(NSLayoutConstraint.init(item: switchButton ?? UISwitch.init(frame: .zero), attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
    }

    func setCellStyle(style:KIBaseSettingCellStyle) {
        var constraints : String
        switch style {
        case .DefaultStyle:
            self.rightLabel.isHidden = true
            self.switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-(>=10)-[rightArrow(8)]-10-|"
            break
        case .DefaultStyle_RightLabel_WithoutRightArrow:
            self.rightArrow?.isHidden = true
            self.switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-(>=10)-[rightLabel]-10-|"
            break
            
        case .DefaultStyle_RightLabel:
            self.switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-(>=10)-[rightLabel]-13-[rightArrow(8)]-10-|"
            break
            
        case .OnlyDisplayLeftLabelStyle:
            self.rightLabel.isHidden = true
            self.rightArrow?.isHidden = true
            self.switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-10-|"
            break
            
        case .SwitchStyle:
            self.rightLabel.isHidden = true
            self.rightArrow?.isHidden = true
            self.switchButton?.isHidden = false
            constraints = "H:|-10-[leftLabel]-(>=10)-[switchButton]-10-|"
            break
        default: break
            
        }
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraints, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: self.cellSubViews as! [String : Any]))
        
    }
    
    func setupImageView(imageView:UIImageView,imageStr:String,imageSize:CGSize,LeftOrRight:NSInteger) {
        
        self.switchButton?.isHidden = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        let imageStr:String = imageStr
        if imageStr.count > 0 {
            if imageStr.hasPrefix("http") || imageStr.hasPrefix("file:") {
                imageView.sd_setImage(with: URL.init(string: imageStr), placeholderImage: nil, options:.refreshCached, completed: nil)
            } else {
                imageView.image = UIImage.init(named: imageStr as String)
            }
            imageView.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(imageView)

            self.cellSubViews = ["leftLabel":leftLabel,"rightLabel":rightLabel,"rightArrow":rightArrow ?? UIImageView.init(frame:.zero) ,"switchButton":switchButton!,"imageView":imageView]
            
            if LeftOrRight == 0 {
                if (self.leftLabelConstraints != nil) {
                    self.contentView.removeConstraints(self.leftLabelConstraints as! [NSLayoutConstraint])
                }
                self.leftImageView = imageView;
                
                self.leftLabelConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imageView(width)]-8-[leftLabel]-10-[rightArrow(8)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["width":(imageSize.width)], views: self.cellSubViews as! [String : Any]) as NSArray
                
                self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView(height)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height" : (imageSize.height)], views: self.cellSubViews as! [String : Any]))
                self.contentView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
                
                self.contentView.addConstraints(self.leftLabelConstraints as! [NSLayoutConstraint])
            
            }
            
            if LeftOrRight == 1 {
                if (self.rightLabelConstraints != nil) {
                    self.contentView.removeConstraints(self.rightLabelConstraints as! [NSLayoutConstraint])
                }
                self.rightImageView = imageView
                self.rightLabelConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[leftLabel]-(>=10)-[imageView(width)]-13-[rightArrow(8)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["width" : (imageSize.width)], views: self.cellSubViews as! [String : Any]) as NSArray
                
                self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView(height)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height" : (imageSize.height)], views: self.cellSubViews as! [String : Any]))
                
                self.contentView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
                
                self.contentView.addConstraints(self.rightLabelConstraints as! [NSLayoutConstraint])
                
            }
            self.setNeedsUpdateConstraints()
            self.updateFocusIfNeeded()
            self.layoutIfNeeded()
        }
        
        //MARK: - layz
        var leftImageCornerRadius : CGFloat = 0.0  {
            didSet {
                self.leftImageView?.layer.masksToBounds = true
                self.leftImageView?.layer.cornerRadius = leftImageCornerRadius
            }
        }
        
        var rightImageCornerRadius : CGFloat = 0.0  {
            didSet {
                self.rightImageView?.layer.masksToBounds = true
                self.rightImageView?.layer.cornerRadius = rightImageCornerRadius
            }
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}
