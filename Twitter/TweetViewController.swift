//
//  TweetViewController.swift
//  Twitter
//
//  Created by Maddie Tong on 2/21/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tweetText.becomeFirstResponder();
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true);
    }
    
    @IBAction func tweetButton(_ sender: Any) {
        if (tweetText.text.isEmpty) {
            self.dismiss(animated: true, completion: nil)
            return;
        }
        
        TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success: { () in
            self.dismiss(animated: true, completion: nil)
        }, failure: {(Error) in print("Tweeting failed!")})
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
