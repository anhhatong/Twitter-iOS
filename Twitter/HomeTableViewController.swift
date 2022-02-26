//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Maddie Tong on 2/19/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweets = [[String : Any]]();
    let myRefreshControl = UIRefreshControl(); // add refresh loader on top of page
    var numTweets: Int!;
    let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"

    @IBOutlet var homeTableView: UITableView!
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout();
        // Dismiss this screen to go back to whatever screen in the stack
        self.dismiss(animated: true, completion: nil);
        UserDefaults.standard.set(false, forKey: "loggedin");
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets();
        // add loader in the current controller, action on func loadTweets()
        self.myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        homeTableView.refreshControl = self.myRefreshControl;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }
    
    @objc func loadTweets() {
        self.numTweets = 10;
        let myParams = ["count": self.numTweets];
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweets = tweets as! [[String:Any]];
            // always reload table view after fetching data
            self.homeTableView.reloadData();
            // hide loading spinner
            self.myRefreshControl.endRefreshing();
        
        }, failure: {(Error) in print("Tweet retrieval failed!")})
    }
    
    func loadMoreTweets() {
        self.numTweets += 10;
        let myParams = ["count": numTweets];
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            self.tweets = tweets as! [[String:Any]];
            // always reload table view after fetching data
            self.homeTableView.reloadData();
        }, failure: {(Error) in print("Tweet retrieval failed!")})
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let tweet = tweets[indexPath.row];
        let content = tweet["text"] as! String;
        let user = tweet["user"] as! NSDictionary;
        let username = user["name"] as! String;
        let profileUrl = URL(string: user["profile_image_url_https"] as! String)
        let data = try? Data(contentsOf: profileUrl!)
        let favorited = tweet["favorited"] as! Bool;
        let retweeted = tweet["retweeted"] as! Bool
        let tweetID = tweet["id"] as! Int;
        
        if let imageData = data {
            cell.profileImage.image = UIImage(data: imageData)
        }
        
        cell.username.text = username;
        cell.tweetContent.text = content;
        cell.setFavorite(isFavorited: favorited)
        cell.setRetweeted(isRetweeted: retweeted)
        cell.tweetID = tweetID;

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets.count {
            loadMoreTweets();
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
