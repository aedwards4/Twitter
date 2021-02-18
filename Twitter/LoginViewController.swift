//
//  LoginViewController.swift
//  Twitter
//
//  Created by Alexis Edwards on 2/9/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0.6351049542, blue: 0.9764973521, alpha: 1)
        loginButton.layer.cornerRadius = 20
        //loginButton.clipsToBounds = true
        //loginButton.layer.borderWidth = 5
        //loginButton.layer.borderColor = #colorLiteral(red: 0.2022203207, green: 0.5553597808, blue: 0.8007673621, alpha: 1)
        loginButton.layer.shadowColor = #colorLiteral(red: 0, green: 0.6351049542, blue: 0.9764973521, alpha: 1)
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        loginButton.layer.shadowRadius = 15
        loginButton.layer.shadowOpacity = 0.8

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey:"userLoggedIn") == true{
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
        
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        
        let myURL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: myURL, success: {
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Could not login")
        })
        
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
