//
//  BusinessesTableViewController.swift
//  iDev Business Viewer live
//
//  Created by Gokulsree Yenugadhati on 1/13/17.
//  Copyright © 2017 Gokul Yenugadhati. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AFNetworking

class BusinessesTableViewController: UITableViewController {
    var businesses: [Business?] = []
    
    var token:String?
    let clientID = "O3JsLqQWkcDaL0Iez-Tf6A"
    let secret = "4HNvk0L4CHpx77xANPtE4vs37Tw6Jm8eB1oLpmG8x9kq26fJmn3SrFW7CHwe6jhJ"
    let baseURL = "https://api.yelp.com/oauth2/token"
    let searchURL = "https://api.yelp.com/v3/businesses/search"
    let location = "West Lafayette, IN"
    
    
    func getToken(){
        Alamofire.request(baseURL, method: .post, parameters: ["grant_type": "client_credentials","client_id": clientID, "client_secret": secret], encoding: URLEncoding.default, headers: nil).responseJSON { response in
            if response.result.isSuccess {
                guard let info = response.result.value else{
                    print("Error")
                    return
                }
                print(info)
                let json = JSON(info)
                print(json)
                
                self.token = json["access_token"].stringValue
                self.loadBusiness()
                
            }
        }
        
    }
    
    
    
    
    
    
    func loadBusiness(){
        Alamofire.request(searchURL, method: .get, parameters: ["location" : location], encoding: URLEncoding.default, headers: ["Authorization" : "Bearer \(token!)"]).validate().responseJSON { response in
            switch response.result.isSuccess {
            case true:
                guard let info = response.result.value else{
                    print("Error")
                    return
                }
                print(info)
                let json = JSON(info)
                print(json)
                let businesses = json["businesses"].arrayValue
                
                for businessJSON in businesses {
                    let businessInfo = Business(json: businessJSON)
                    self.businesses.append(businessInfo)
                }
               self.tableView.reloadData()
               
            case false:
                print(response.result.error?.localizedDescription ?? "error")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return businesses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        let row = indexPath.row
        
        guard let businessInfo = businesses[row] else{
            return cell
        }
        cell.nameLabel.text = businessInfo.name
        cell.ratingLabel.text = "\(businessInfo.rating)"
        cell.priceLabel.text = businessInfo.price
        cell.distanceLabel.text = "\(businessInfo.distance)"
        cell.typeLabel.text = businessInfo.type
        cell.locationLabel.text = businessInfo.location
        let imageURL = URL(string: businessInfo.imageURL)
        cell.picView.setImageWith(imageURL!)
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! BusinessCell
        let destination = segue.destination as! ViewController
        let row = tableView.indexPath(for: cell)?.row
        let business = businesses[row!]
        
        destination.business = business
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
