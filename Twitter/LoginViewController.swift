//
//  LoginViewController.swift
//  Twitter
//
//  Created by Maddie Tong on 2/19/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "loggedin")) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
            UserDefaults.standard.set(true, forKey: "loggedin");
        }, failure: { (Error) in
            print("Login failed!")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
