//
//  InvitationHomeViewController.swift
//  Invitation
//
//  Created by MAC219-Darshan on 27/10/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//
import UIKit

enum FriendName {
     case sonal
     case vikas
     case chirag
     case janki
     case banu
     case neel
     case giteeka
}

struct TableViewDataModel {
     var title:String = ""
     var subTitle:String = ""
}

class InvitationHomeViewController: UIViewController,NavigationConfigurationProtocol{

     
     @IBOutlet weak var tableViewHome:UITableView!
     
     var tableViewObjects:[TableViewDataModel] = []
     
     var friendName:FriendName = FriendName.sonal
     
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          //self.performSegue(withIdentifier: "pushToDetail", sender: nil)
          
          var objectConfiguration = Configuration()
          print(objectConfiguration.environment)
          
          self.friendName = .sonal
        //Configure NavigationTitle
        self.configureNavigationTitle(strTitle: "adios tatvasoft")
          
        //Configure TableView DataModel
        self.configureTableViewModel()
          
        //Configure TableView
        self.configureTableView()
       
        
     }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
     }
     // MARK: - Custom Methods
     func getFriendMessage()-> String{
          switch self.friendName {
          case .sonal :
               return "self declared cuttest girl #december baby #fight for her diary :P#wtup & insta story queen"
          case .vikas :
               return "#sathi bandhu #college friend#lunch partner #simple living and high thinking"
          case .chirag :
               return "most beautiful from heart #different personality #good reader #mature boy"
          case .janki :
               return "#kansagara sister 1#chapli #beautiful girl #great human being #difficult smile #pics lover"
          case .banu :
               return "#maharana pratap's FAN #kansagara sister 2 #positive thinker #girl who know me most"
          case .neel :
               return "#brother as well #schoolmates #best friends #together we can do more"
          case .giteeka :
               return "No matter how hard time we face in our friendship but u were,u r & u will be my ever close friend."
          }
     }
     func configureTableView(){
         tableViewHome.delegate = self
         tableViewHome.dataSource = self
         tableViewHome.estimatedRowHeight = 100
         tableViewHome.tableFooterView = UIView()
         tableViewHome.tableHeaderView = UIView()
     }
     func configureTableViewModel(){
          let titles:[String] = ["Tatvasoft Journey","Few words for you","Farewell Invitation"]
          let subTitles:[String] = ["#Story began on 20-july-2015 @ ISCON Elegance #Mobile Development #iOS developer#Friends and supportive seniors #learning curve on it's edge #it's time to final bye","for me \(self.friendName) is \(self.getFriendMessage())","let's celebarate together @Domino's Pizza ISCON and make it auspicious"]
          for i in 0..<3{
              tableViewObjects.append(TableViewDataModel(title: titles[i], subTitle: subTitles[i]))
          }
     }
     // MARK: - Selector Methods
     @IBAction func buttonTestSelector(sender:UIButton){
          
     }
     
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
          if segue.identifier == "PresentDetail"{
               let detailViewController = segue.destination as! DetailViewController
                detailViewController.detailFriendName = self.friendName
          }
     }
}
extension InvitationHomeViewController:UIPopoverPresentationControllerDelegate{
     
     func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
          return .none
     }
     
}
extension InvitationHomeViewController:UITableViewDelegate,UITableViewDataSource{
     
     func numberOfSections(in tableView: UITableView) -> Int {
          return self.tableViewObjects.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.getTableViewCellLoadFromXIBUsing(reusableID: "HomeTableViewCell") as! HomeTableViewCell
          let objModel = self.tableViewObjects[indexPath.section]
          cell.strTitle.text = "\(objModel.title)"
          cell.strSubTitle.text = "\(objModel.subTitle)"
          cell.strTitle.alpha = 0.0
          cell.strSubTitle.alpha = 0.0
          cell.tag = indexPath.section
          DispatchQueue.main.asyncAfter(deadline: .now()+(3.0*Double(indexPath.section))) {
               UIView.animate(withDuration: 0.5, animations: {
                    cell.strTitle.alpha = 1.0
                    cell.strSubTitle.alpha = 1.0
               })
               if cell.tag == 2{
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: { 
                         self.performSegue(withIdentifier: "PresentDetail", sender: nil)
                    })
               }
          }
          return cell
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return UITableViewAutomaticDimension
     }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 10.0
     }
     /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if indexPath.section == 2{
               self.performSegue(withIdentifier: "PresentDetail", sender: nil)
          }
          UIView.animate(withDuration: 0.2, animations: {
               //tableView.reloadRows(at: [indexPath], with: .automatic)
          }) { (animaeted:Bool) in
               UIView.animate(withDuration: 0.3, animations: {
                    tableView.reloadRows(at: [indexPath], with: .automatic)
               }, completion: nil)
          }
     }*/
     
}
