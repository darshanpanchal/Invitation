//
//  CommonClass.swift
//  Invitation
//
//  Created by MAC219-Darshan on 27/10/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import UIKit


let kMuliFontNames = "Muli-Regular"
let kIndieFlower = "IndieFlower"
let kMuliBold = "Muli-Bold"

let kIPHONE_7_WIDTH:CGFloat = 375.0
let kIPHONE_7_HEIGHT:CGFloat = 667.0
let kAppTintColor = UIColor(colorLiteralRed: 75.0/255.0, green: 0.0/255.0, blue: 130.0/255.0, alpha: 1.0)

class CommonClass: NSObject {

     //SingleTon Object
     static let shared:CommonClass = CommonClass()

}
protocol NavigationConfigurationProtocol:NSObjectProtocol {
     
}
extension NavigationConfigurationProtocol where Self:UIViewController{
     func configureNavigationTitle(strTitle:String){
          let titleLabel = UILabel()
          titleLabel.attributedText = NSAttributedString(string: "\(strTitle)", attributes:
               [NSFontAttributeName:UIFont.init(name: kIndieFlower, size: 25.0) ?? UIFont.boldSystemFont(ofSize: 15.0)])
          titleLabel.sizeToFit()
          titleLabel.textColor = UIColor.white
          self.navigationItem.titleView = titleLabel
          self.navigationController?.isNavigationBarHidden = false
          self.navigationController?.navigationBar.barTintColor = kAppTintColor
          self.navigationController?.navigationBar.tintColor = UIColor.white
     }
}
//TableView Extension
extension UITableView{
     //GET TableView Cell From TableVIew Item
     func getTableViewCellUsing(reusableID:String) -> UITableViewCell{
          if let cell = self.dequeueReusableCell(withIdentifier:reusableID){
               return cell
          }else{
               return UITableViewCell.init(style: .default, reuseIdentifier:reusableID)
          }
     }
     
     //GET TableViewCell From XIB.
     //Make Sure that reusableID and XIB names are same
     func getTableViewCellLoadFromXIBUsing(reusableID:String)->UITableViewCell?{
          if let cell = self.dequeueReusableCell(withIdentifier: reusableID){
               return cell
          }else{
               self.register(UINib.init(nibName: reusableID, bundle: nil), forCellReuseIdentifier: reusableID)
               return self.dequeueReusableCell(withIdentifier: reusableID)
          }
     }
}

extension CGFloat{
     var mainScreenWidth:CGFloat{
          return UIScreen.main.bounds.width
     }
     var mainScreenHeight:CGFloat{
          return UIScreen.main.bounds.height
     }
     var propotionalWidth:CGFloat{
          return self*mainScreenWidth/kIPHONE_7_WIDTH
     }
     var propotionalHeight:CGFloat{
          return self*mainScreenHeight/kIPHONE_7_HEIGHT
     }
}
extension UIFont{
      static var namesFont:[String]{
          var names:[String] = []
          for familyName in UIFont.familyNames {
               for name in UIFont.fontNames(forFamilyName: familyName){
                    names.append(name)
               }
          }
          return names
     }
}
