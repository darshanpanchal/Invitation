//
//  Configuration.swift
//  Invitation
//
//  Created by MAC219-Darshan on 02/11/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//
import UIKit
import Foundation
//File build configuration using manage schema
enum Environment :String{
     case Staging = "staging"
     case Production = "production"
     
     var baseURL:String{
          switch self {
          case .Staging:
               return "StagingURL"
          case  .Production:
               return "ProductionURL"
          }
     }
}
struct Configuration {
     lazy var environment:Environment = {
          if let strConfiguration:String = Bundle.main.object(forInfoDictionaryKey:"Configuration") as? String{
               if (strConfiguration.range(of: "Staging") != nil){
                    return .Staging
               }
          }
          return .Production
     }()
}
