//
//  HomeTableViewCell.swift
//  Twitter
//
//  Created by Maddie Tong on 2/19/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var favorited : Bool = false
    var tweetID : Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        // if currently favorited -> unfavorite
        print(tweetID);
        if(favorited) {
            TwitterAPICaller.client?.unfavorite(tweetID: tweetID, success: {
                self.setFavorite(isFavorited: false)
            }, failure: {(Error) in
                print("Unfavorite failed!")})
        } else { // if currently unfavorited -> favorite
            TwitterAPICaller.client?.favorite(tweetID: tweetID, success: {
                self.setFavorite(isFavorited: true)
            }, failure: {(Error) in
                print("Favorite failed!")})
        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
    }
    
    func setFavorite(isFavorited : Bool) {
        favorited = isFavorited;
        if (isFavorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
