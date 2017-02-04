//
//  ViewController.swift
//  iDev Business Viewer live
//
//  Created by Gokulsree Yenugadhati on 1/11/17.
//  Copyright © 2017 Gokul Yenugadhati. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    var business: Business?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let businessInfo = business else{
            return
        }
        nameLabel.text = businessInfo.name
        phoneNumberLabel.text = businessInfo.phoneNumber
        priceLabel.text = businessInfo.price
        locationLabel.text = businessInfo.location
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var pictureView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var token:String?
    let clientID = "O3JsLqQWkcDaL0Iez-Tf6A"
    let secret = "4HNvk0L4CHpx77xANPtE4vs37Tw6Jm8eB1oLpmG8x9kq26fJmn3SrFW7CHwe6jhJ"
    let baseURL = "https://api.yelp.com/oauth2/token"
    let searchURL = "https://api.yelp.com/v3/businesses/search"
    let location = "West Lafayette, IN"
//    func getToken(){
//        Alamofire.request(baseURL, method: .post, parameters: ["grant_type": "client_credentials","client_id": clientID, "client_secret": secret], encoding: URLEncoding.default, headers: nil).responseJSON { response in
//            if response.result.isSuccess {
//                guard let info = response.result.value else{
//                    print("Error")
//                    return
//                }
//                print(info)
//                let json = JSON(info)
//                print(json)
//                
//                self.token = json["access_token"].stringValue
//                self.loadBusiness()
//                
//            }
//        }
//        
//    }
//    func loadBusiness(){
//        Alamofire.request(searchURL, method: .get, parameters: ["location" : location], encoding: URLEncoding.default, headers: ["Authorization" : "Bearer \(token!)"]).validate().responseJSON { response in
//            if response.result.isSuccess {
//                guard let info = response.result.value else{
//                    print("Error")
//                    return
//                }
//                //print(info)
//                let json = JSON(info)
//                //print(json)
//                let businesses = json["businesses"].arrayValue
//                let business = businesses[0]
//                print (business)
//                
//                self.nameLabel.text = business["name"].stringValue
//                self.priceLabel.text = business["name"].stringValue
//                self.phoneNumberLabel.text = business["display_phone"].stringValue
//                let locationD = business["location"]["address1"]
//                let locationString = locationD.stringValue
//                let cityStringD = business["location"]["city"]
//                let cityString = cityStringD.stringValue
//                self.locationLabel.text = "\(locationString),\(cityString)"
//                
//                let imageUrl = URL(string: business["image_url"].stringValue)
//                let imageRequest = URLRequest(url:imageUrl!)
//                let session = URLSession(configuration: .default)
//                
//                session.dataTask(with: imageRequest, completionHandler:
//                    {(data,response,error) in
//                        guard let image = data else{
//                            print(error?.localizedDescription ?? "error")
//                            return
//                        }
//                        self.pictureView.image = UIImage(data:image)}).resume()
//                }
//        
//
//            }
//        }
    }


