//
//  TweetViewController.swift
//  Twitter
//
//  Created by Alexis Edwards on 2/16/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var charCount: UILabel!
    var userInfo = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Styling the profileImageView
        //placeholder image until I can replace with user's profile image
        let image = UIImage(named: "TwitterLogoBlue")
        profileImage.image = image
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = #colorLiteral(red: 0, green: 0.6917446852, blue: 1, alpha: 1)
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = (profileImage?.frame.size.width ?? 0.0) / 2
        
        // Styling the textView
        tweetTextView.delegate = self
        tweetTextView.text = " What are you thinking?"
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.layer.cornerRadius = 15
        tweetTextView.layer.borderWidth = 3.0
        tweetTextView.layer.borderColor = #colorLiteral(red: 0, green: 0.6917446852, blue: 1, alpha: 1)

        //Commented out in order to use placeholder text
        //tweetTextView.becomeFirstResponder()
        
        //Retrieving user info
        let userURL = "https://api.twitter.com/1.1/users/show.json"
        let myParams = ["screen_name":"aelauve"]

        TwitterAPICaller.client?.getDictionaryRequest(url: userURL, parameters: myParams, success: { (info: NSDictionary) in
            self.userInfo = info
            print(self.userInfo)
            
            let url = URL(string: self.userInfo["profile_image_url"] as! String)
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            self.profileImage.image = UIImage(data: data!)
            
            
        }, failure: { (Error) in
            print("Could not retrieve data! Oh no!")
        })
    }
    
    //Implementing character count
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        // TODO: Update Character Count Label
        let count = characterLimit - newText.count
        charCount.text = String(count)
        if (count <= 20){
            charCount.textColor = #colorLiteral(red: 1, green: 0, blue: 0.09898722917, alpha: 1)
        }

        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
    
    
    //The following two functions were borrowed from Stack Overflow
    //
    func textViewDidBeginEditing(_ tweetTextView: UITextView) {
        if tweetTextView.textColor == UIColor.lightGray {
            tweetTextView.text = nil
            tweetTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = " What are you thinking?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet")
            })
        }
        else{
            //replace with alert controller
            self.dismiss(animated: true, completion: nil)
        }
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
