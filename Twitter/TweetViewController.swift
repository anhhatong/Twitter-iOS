//
//  TweetViewController.swift
//  Twitter
//
//  Created by Maddie Tong on 2/21/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetText: UITextView!
    
    @IBOutlet weak var charCountLabel: UILabel!
    
    let MAX_CHAR = 280;
    var remainingCount = 280;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tweetText.delegate = self;
        tweetText.becomeFirstResponder();
        charCountLabel.text = String(MAX_CHAR);
    }
    
    @IBOutlet weak var tweetBarButton: UIBarButtonItem!
    
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
    
    // textView.text! is the prev string excluding the current char
    // text is the current char
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        self.remainingCount = MAX_CHAR - newText.count
        charCountLabel.text = String(self.remainingCount);
        
       // Always allow users to type
        return true
    }
    
    // called when text field changes
    func textViewDidChange(_ textView: UITextView) {
        if (self.remainingCount < 0) {
            charCountLabel.textColor = UIColor.red;
            textView.textColor = UIColor.red;
            tweetBarButton.isEnabled = false;
        } else {
            charCountLabel.textColor = UIColor.black;
            textView.textColor = UIColor.black;
            tweetBarButton.isEnabled = true;
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
