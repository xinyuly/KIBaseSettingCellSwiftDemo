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
            leftImageView = UIImageView.init()
            leftImageView?.contentMode = .scaleAspectFill
            leftImageView?.clipsToBounds = true
            setupImageView(imageView: leftImageView!, imageStr: leftImageStr, imageSize: leftImageSize, LeftOrRight: 0)
        }
        
        if rightImageStr.count > 0 {
            rightImageView = UIImageView.init()
            rightImageView?.contentMode = .scaleAspectFill
            rightImageView?.clipsToBounds = true
            setupImageView(imageView: rightImageView!, imageStr: rightImageStr, imageSize: rightImageSize, LeftOrRight: 1)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize()  {
        leftLabel = UILabel.init()
        leftLabel.font = UIFont.systemFont(ofSize: 16.0)
        leftLabel.textColor = UIColor.black
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rightLabel = UILabel.init()
        rightLabel.font = UIFont.systemFont(ofSize: 14.0)
        rightLabel.textColor = UIColor.lightText
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rightArrow = UIImageView.init()
        rightArrow?.image = UIImage.init(named: "right_arrow")
        rightArrow?.translatesAutoresizingMaskIntoConstraints = false
        
        switchButton = UISwitch.init()
        switchButton?.addTarget(self, action: #selector(onClickSwitch(sender:)), for: UIControlEvents.valueChanged)
        switchButton?.isOn =  switchButtonStatus
        switchButton?.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLine = UIView.init()
        bottomLine?.backgroundColor = UIColor.lightGray
        bottomLine?.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview( leftLabel)
        contentView.addSubview( rightLabel)
        contentView.addSubview( rightArrow!)
        contentView.addSubview( switchButton!)
        contentView.addSubview( bottomLine!)
        
        cellSubViews = ["leftLabel":leftLabel,"rightLabel":rightLabel,"rightArrow":rightArrow ?? UIImageView.init(frame: .zero) ,"switchButton":switchButton ?? UISwitch.init(frame: .zero),"bottomLine":bottomLine ?? UIView.init(frame: .zero)]
        setLayout()
        
    }
    
    @objc func onClickSwitch(sender:UISwitch) {
        if (delegate) != nil {
            delegate?.onClickSwitchButton(sender: sender)
        }
    }
    
    func setLayout() {
        
         contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[leftLabel(21)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  cellSubViews as! [String : Any]))
        
         contentView.addConstraint(NSLayoutConstraint.init(item: leftLabel, attribute: .centerY, relatedBy: .equal, toItem:  contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        
         contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[rightLabel(21)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  cellSubViews as! [String : Any]))
        
         contentView.addConstraint(NSLayoutConstraint.init(item: rightLabel, attribute: .centerY, relatedBy: .equal, toItem:  contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
        
         contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[rightArrow(13)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  cellSubViews as! [String : Any]))
        
         contentView.addConstraint(NSLayoutConstraint.init(item: rightArrow ?? UIImageView.init(frame: .zero), attribute: .centerY, relatedBy: .equal, toItem:  contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
         contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[bottomLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  cellSubViews as! [String : Any]))
        
         contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomLine(0.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  cellSubViews as! [String : Any]))
         contentView.addConstraint(NSLayoutConstraint.init(item: switchButton ?? UISwitch.init(frame: .zero), attribute: .centerY, relatedBy: .equal, toItem:  contentView, attribute: .centerY, multiplier: 1, constant: 0))
        
    }

    func setCellStyle(style:KIBaseSettingCellStyle) {
        var constraints : String
        switch style {
        case .DefaultStyle:
             rightLabel.isHidden = true
             switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-(>=10)-[rightArrow(8)]-10-|"
            break
        case .DefaultStyle_RightLabel_WithoutRightArrow:
             rightArrow?.isHidden = true
             switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-(>=10)-[rightLabel]-10-|"
            break
            
        case .DefaultStyle_RightLabel:
             switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-(>=10)-[rightLabel]-13-[rightArrow(8)]-10-|"
            break
            
        case .OnlyDisplayLeftLabelStyle:
             rightLabel.isHidden = true
             rightArrow?.isHidden = true
             switchButton?.isHidden = true
            constraints = "H:|-10-[leftLabel]-10-|"
            break
            
        case .SwitchStyle:
             rightLabel.isHidden = true
             rightArrow?.isHidden = true
             switchButton?.isHidden = false
            constraints = "H:|-10-[leftLabel]-(>=10)-[switchButton]-10-|"
            break
        default: break
            
        }
        
         contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraints, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views:  cellSubViews as! [String : Any]))
        
    }
    
    func setupImageView(imageView:UIImageView,imageStr:String,imageSize:CGSize,LeftOrRight:NSInteger) {
        
        switchButton?.isHidden = true
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
             contentView.addSubview(imageView)

             cellSubViews = ["leftLabel":leftLabel,"rightLabel":rightLabel,"rightArrow":rightArrow ?? UIImageView.init(frame:.zero) ,"switchButton":switchButton!,"imageView":imageView]
            
            if LeftOrRight == 0 {
                if ( leftLabelConstraints != nil) {
                     contentView.removeConstraints( leftLabelConstraints as! [NSLayoutConstraint])
                }
                 leftImageView = imageView;
                
                 leftLabelConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imageView(width)]-8-[leftLabel]-10-[rightArrow(8)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["width":(imageSize.width)], views:  cellSubViews as! [String : Any]) as NSArray
                
                 contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView(height)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height" : (imageSize.height)], views:  cellSubViews as! [String : Any]))
                 contentView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem:  contentView, attribute: .centerY, multiplier: 1, constant: 0))
                
                 contentView.addConstraints( leftLabelConstraints as! [NSLayoutConstraint])
            
            }
            
            if LeftOrRight == 1 {
                if ( rightLabelConstraints != nil) {
                     contentView.removeConstraints( rightLabelConstraints as! [NSLayoutConstraint])
                }
                 rightImageView = imageView
                 rightLabelConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[leftLabel]-(>=10)-[imageView(width)]-13-[rightArrow(8)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["width" : (imageSize.width)], views:  cellSubViews as! [String : Any]) as NSArray
                
                 contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView(height)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["height" : (imageSize.height)], views:  cellSubViews as! [String : Any]))
                
                 contentView.addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerY, relatedBy: .equal, toItem:  contentView, attribute: .centerY, multiplier: 1, constant: 0))
                
                 contentView.addConstraints( rightLabelConstraints as! [NSLayoutConstraint])
                
            }
             setNeedsUpdateConstraints()
             updateFocusIfNeeded()
             layoutIfNeeded()
        }
        
        //MARK: - layz
        var leftImageCornerRadius : CGFloat = 0.0  {
            didSet {
                 leftImageView?.layer.masksToBounds = true
                 leftImageView?.layer.cornerRadius = leftImageCornerRadius
            }
        }
        
        var rightImageCornerRadius : CGFloat = 0.0  {
            didSet {
                 rightImageView?.layer.masksToBounds = true
                 rightImageView?.layer.cornerRadius = rightImageCornerRadius
            }
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}
