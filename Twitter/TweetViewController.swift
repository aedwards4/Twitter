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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //placeholder image until I can replace with user's profile image
        let image = UIImage(named: "TwitterLogoBlue")
        profileImage.image = image
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = #colorLiteral(red: 0, green: 0.6917446852, blue: 1, alpha: 1)
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = (profileImage?.frame.size.width ?? 0.0) / 2
        
        
        tweetTextView.delegate = self
        tweetTextView.text = "What are you thinking?"
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.layer.cornerRadius = 15
        tweetTextView.layer.borderWidth = 3.0
        tweetTextView.layer.borderColor = #colorLiteral(red: 0, green: 0.6917446852, blue: 1, alpha: 1)

        //Commented out in order to use placeholder text
        //tweetTextView.becomeFirstResponder()
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
            textView.text = "What are you thinking?"
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
