
//
//  DetailViewController.swift
//  Invitation
//
//  Created by MAC219-Darshan on 27/10/17.
//  Copyright © 2017 tatvasoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


let kCustomAnnotationID:String = "CustomAnnotation"

enum DetailType {
     case Tatvasoft
     case Frienship
     case Invitation
}
class DetailViewController: UIViewController ,NavigationConfigurationProtocol{

     @IBOutlet weak var friendShipSelector:UIButton!
     @IBOutlet weak var tableViewDetail:UITableView!
     @IBOutlet weak var tableViewHeader:UIView!
     @IBOutlet weak var tableViewFooter:UIView!
     @IBOutlet weak var venueMapView:MKMapView!
     
     
     var detailControllerType:DetailType = DetailType.Tatvasoft
     var detailFriendName:FriendName = FriendName.sonal
     var dataModels:[TableViewDataModel] = []
     var isAnnotationAdded:Bool = false{
          didSet{
                self.addAnnotationOnMapView()
          }
     }
     //Core Location Manager 
     var coreLocationManager:CLLocationManager = CLLocationManager()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
     
        //Congigure Friendship selector
        self.configureSelector()
     
        //Configure NavigationController
        self.configureNavigationTitle(strTitle: "when it will be?")
     
        //Configure TableView
        self.configureTableView()
     
     
     if CLLocationManager.locationServicesEnabled(){
          //Configure LocationManager
          self.configureLocationManager()
     }else{
          self.present(UIAlertController.init(title: "Location", message: "Please enable location service.", preferredStyle: .alert), animated: true, completion: nil)
          
     }
     
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
     
          
    }
     
    // MARK: - Custom Methods
     func configureLocationManager(){
          self.coreLocationManager.delegate = self
          self.coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
          self.coreLocationManager.requestWhenInUseAuthorization()
          self.coreLocationManager.startUpdatingLocation()
          
          //Configure MapKit
          self.configureMKMapKit()
     }
     func configureMKMapKit(){
          self.venueMapView.delegate = self
          self.venueMapView.showsUserLocation  = true
     }
     func configureSelector(){
          let attributedTitle = NSAttributedString(string: "\(self.detailFriendName)", attributes:
               [NSFontAttributeName:UIFont.init(name: kIndieFlower, size: 25.0) ?? UIFont.boldSystemFont(ofSize: 15.0),NSForegroundColorAttributeName:kAppTintColor])
          self.friendShipSelector.setAttributedTitle(attributedTitle, for: .normal)
     }
     func configureTableView(){
        
          tableViewDetail.delegate = self
          tableViewDetail.dataSource = self
          tableViewDetail.sectionFooterHeight = UITableViewAutomaticDimension
          tableViewDetail.sectionHeaderHeight = UITableViewAutomaticDimension
          tableViewDetail.rowHeight = UITableViewAutomaticDimension
          tableViewDetail.estimatedRowHeight = 100.0
          tableViewDetail.estimatedSectionHeaderHeight = 100.0
          tableViewDetail.estimatedSectionFooterHeight = 100.0
               if let _ = self.tableViewDetail.tableHeaderView{
                    self.tableViewDetail.tableHeaderView = self.tableViewHeader
               }
               if let _ = self.tableViewDetail.tableFooterView{
                    self.tableViewDetail.tableFooterView = self.tableViewFooter
               }
          let titles:[String] = ["On friday evening","Venue"]
          let subTitles:[String] = ["10-11-2017 07:00 pm","Domino's Pizza ISCON 23.0276° N, 72.5084° E"]
          
          for i in 0 ..< titles.count {
               dataModels.append(TableViewDataModel(title: "\(titles[i])", subTitle: "\(subTitles[i])"))
          }
     }
     func addAnnotationOnMapView(){
          let annotation = MKPointAnnotation()
          //23.023686462844097 72.589330784893988
          //23.02379678449708 72.589558174275311
          //23.023354321669245 72.588694333876091
          //23.023673395776498 72.588578406989001
          //23.0276611 72.5084042
          let coordinate = CLLocationCoordinate2D(latitude:	23.0276611, longitude:72.5084042)
          annotation.coordinate = coordinate
       

          
          let objCLGeocoder:CLGeocoder = CLGeocoder.init()
          objCLGeocoder.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)) { (placeMarks:[CLPlacemark]?, error:Error?) in
               let objPlaceMark:CLPlacemark = placeMarks![0]
               if let objFormattedAddressLines:NSArray = objPlaceMark.addressDictionary?["FormattedAddressLines"] as? NSArray{
                    annotation.title = "\(objFormattedAddressLines.componentsJoined(by:","))"
                    annotation.accessibilityValue = "\(self.getImageURLFromCoordinate(coordinate: coordinate))"
                    self.venueMapView?.addAnnotation(annotation)
               }
          }
         /*
          let annotation = MKPointAnnotation()
          let centerCoordinate = CLLocationCoordinate2D(latitude:23.03255, longitude:72.5981)
          annotation.coordinate = centerCoordinate
          annotation.title = "Manek Chawk"
          self.venueMapView.addAnnotation(annotation)*/
          
          UIView.animate(withDuration: 0.3) {
               let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
               self.venueMapView.setRegion(region, animated: true)
               //self.venueMapView.setCenter(coordinate, animated: true)
          }
     }
     func getImageURLFromCoordinate(coordinate:CLLocationCoordinate2D) -> String{
          let Width = 200
          let Height = 100
          
          let mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?center="
          let latlong = "\(coordinate.latitude), \(coordinate.longitude)"
          
          let mapUrl  = mapImageUrl + latlong
          
          let size = "&size=" +  "\(Int(Width))" + "x" +  "\(Int(Height))"
          let positionOnMap = "&markers=size:mid|color:red|" + latlong
          let mapType = "&maptype=hybrid"
          let staticImageUrl = mapUrl + size + positionOnMap + mapType
          
          if let urlStr = staticImageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
               // setImageFromURL
               return urlStr
          }
          return ""
     }
     // MARK: - Selector Methods
     @IBAction func buttonUserSelection(sender:UIButton!){
          if let objectViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController{
               objectViewController.objectFriendName = self.detailFriendName
               let objectNavigation = UINavigationController(rootViewController: objectViewController)
               objectNavigation.modalPresentationStyle = .popover
               objectNavigation.isNavigationBarHidden = true
               let popOverController = objectNavigation.popoverPresentationController
               popOverController?.permittedArrowDirections = .up
               popOverController?.sourceView = self.friendShipSelector
               popOverController?.sourceRect = self.friendShipSelector.bounds
               popOverController?.delegate = self
               self.present(objectNavigation, animated: true, completion: nil)
          }

     }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
    }
}
extension DetailViewController:UIPopoverPresentationControllerDelegate{
     
     func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
          return .none
     }
}
extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
     

     func numberOfSections(in tableView: UITableView) -> Int {
          return 1//self.dataModels.count
     }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return self.dataModels.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.getTableViewCellLoadFromXIBUsing(reusableID: "HomeTableViewCell") as! HomeTableViewCell
          let objModel = dataModels[indexPath.row]
          cell.strTitle.text = "\(objModel.title)"
          cell.strSubTitle.text = "\(objModel.subTitle)"
          return cell
     }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return UITableViewAutomaticDimension
     }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

          return UITableViewAutomaticDimension
     }
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
          return UITableViewAutomaticDimension
     }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
          if indexPath.row == 1 ,!isAnnotationAdded{
               //Add ManekChawk Annotation on MapView
              self.isAnnotationAdded = true
          }
          UIView.animate(withDuration: 0.2) { 
               UIView.animate(withDuration:0.2, animations: { 
                    tableView.reloadRows(at: [indexPath], with: .automatic)
               })
          }
     }
     
}
extension DetailViewController:CLLocationManagerDelegate{
     /*
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          print("Location Upadate \(locations.last)")
     }*/
}
extension DetailViewController:MKMapViewDelegate{
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          if annotation.isKind(of: MKPointAnnotation.self){
               var objMKAnnotationView:MKPinAnnotationView?
               
               if let annotationView = self.venueMapView?.dequeueReusableAnnotationView(withIdentifier: kCustomAnnotationID) as? MKPinAnnotationView{
                    objMKAnnotationView  = annotationView
               }else{
                    objMKAnnotationView  = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: kCustomAnnotationID)
                    objMKAnnotationView?.canShowCallout = true
               }
               objMKAnnotationView?.pinTintColor = .purple
               
               let detailAccessoryView = UIView()
               let detailImageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 5, y: 5, width: 190, height: 90))
               //detailImageView.image = UIImage(named: "ManekChawk")
               
               if let strImageURL = (annotation as! MKPointAnnotation).accessibilityValue{
                    let url = URL(string: strImageURL)
                    do {
                         let data = try NSData(contentsOf: url!, options: NSData.ReadingOptions())
                         detailImageView.image = UIImage(data: data as Data)
                    } catch {
                         detailImageView.image = UIImage.init(named: "location")
                    }
               }else{
                    detailImageView.image = UIImage.init(named: "location")
               }
               let views = ["detailAccessoryView":detailAccessoryView]
               
               detailAccessoryView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[detailAccessoryView(200.0)]", options: [], metrics: nil, views: views))
               detailAccessoryView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[detailAccessoryView(100.0)]", options: [], metrics: nil, views: views))
               detailImageView.contentMode = .scaleAspectFit
               detailAccessoryView.addSubview(detailImageView)
               objMKAnnotationView?.detailCalloutAccessoryView = detailAccessoryView
               return objMKAnnotationView
          }else{
               return nil
          }
     }
}



