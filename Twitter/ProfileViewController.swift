//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Alexis Edwards on 2/18/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    var userInfo = NSDictionary()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Styling the profileImageView
        //placeholder image until I can replace with user's profile image
        let image = UIImage(named: "TwitterLogoBlue")
        profilePicImageView.image = image
        profilePicImageView.layer.borderWidth = 3.0
        profilePicImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        profilePicImageView.clipsToBounds = true
        profilePicImageView.layer.cornerRadius = (profilePicImageView?.frame.size.width ?? 0.0) / 2
        
        //Retrieving user info
        let userURL = "https://api.twitter.com/1.1/users/show.json"
        let myParams = ["screen_name":"aelauve"]

        TwitterAPICaller.client?.getDictionaryRequest(url: userURL, parameters: myParams, success: { (info: NSDictionary) in
            self.userInfo = info
            //print(self.userInfo)
            
            //Setting profile image
            let url = URL(string: self.userInfo["profile_image_url"] as! String)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            self.profilePicImageView.image = UIImage(data: data!)
            
            //Setting header image
            if self.userInfo["profile_banner_url"] != nil{
                let url2 = URL(string: self.userInfo["profile_banner_url"] as! String)
                if let data2 = try? Data(contentsOf: url2!){
                    self.headerImageView.image = UIImage(data: data2)
                }
            }
            else{
                self.headerImageView.backgroundColor = #colorLiteral(red: 0, green: 0.6351049542, blue: 0.9764973521, alpha: 1)
            }
            
            //Setting name label
            self.nameLabel.text = (self.userInfo["name"] as! String)
            
            //Setting handle label
            self.handleLabel.text = "@\(self.userInfo["screen_name"] as! String)"
            
            //Setting description label
            if self.userInfo["description"] != nil{
                self.descriptionLabel.text = self.userInfo["description"] as! String
            }
            else{
                self.descriptionLabel.text = ""
                self.descriptionLabel.sizeToFit()
            }
            
            //Setting followers and following count
            let count1 = self.userInfo["followers_count"]
            let count2 = self.userInfo["friends_count"]
            self.followerCount.text = String(count1 as! Int)
            self.followingCount.text = String(count2 as! Int)
            
        }, failure: { (Error) in
            print("Could not retrieve data! Oh no!")
        })

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
