//
//  HomeTableViewCell.swift
//  Invitation
//
//  Created by MAC219-Darshan on 27/10/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

     
    @IBOutlet weak var strTitle:UILabel!
    @IBOutlet weak var strSubTitle:UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.strTitle.font = UIFont(name: kMuliBold, size:20.0)
        self.strTitle.textColor = kAppTintColor
     
        self.strSubTitle.font = UIFont(name: kIndieFlower, size:20.0)
        self.strSubTitle.textColor = kAppTintColor
     //self.objectUILabel.backgroundColor = UIColor(colorLiteralRed: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        self.backgroundColor = UIColor.white
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
     func transformView(){
          self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
          UIView.animate(withDuration: 0.2, delay: 0.0, options: .allowAnimatedContent, animations: {
               self.layoutIfNeeded()
               self.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
          }) { (animated:Bool) in
               UIView.animate(withDuration: 0.2, delay: 0.0, options: .allowAnimatedContent, animations: {
                    self.layoutIfNeeded()
                    self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
               }, completion: { (animated:Bool) in
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .allowAnimatedContent, animations: {
                         self.layoutIfNeeded()
                         self.transform = CGAffineTransform.init(scaleX: 1.05, y: 1.05)
                    }, completion: { (animated:Bool) in
                         UIView.animate(withDuration: 0.2, delay: 0.0, options: .allowAnimatedContent, animations: {
                              self.layoutIfNeeded()
                              self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                              //self.transform = CGAffineTransform.init(scaleX: 1.10, y: 1.10)
                         }, completion: { (animated:Bool) in
                              //self.layoutIfNeeded()
                              //self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                         })
                    })
               })
          }
     }
}
