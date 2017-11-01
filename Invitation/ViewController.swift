//
//  ViewController.swift
//  Invitation
//
//  Created by MAC219-Darshan on 27/10/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     @IBOutlet weak var objectUIImageView:UIImageView!
     
     var imageObject:UIImage = UIImage(named:"User")!
     
     override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view, typically from a nib.
          self.objectUIImageView.image = imageObject
     }
     override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
     }
     override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          
     }

}

