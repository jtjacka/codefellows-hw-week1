//
//  TweetDetailViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/5/15.
//
//

import UIKit

class TweetDetailViewController: UIViewController {

  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var profileUsername: UILabel!
  @IBOutlet weak var tweetText: UILabel!
  @IBOutlet weak var profileName: UILabel!
  
  var tweet : Tweet?
  
  
  override func viewWillAppear(animated: Bool) {
    
    if let tweet = tweet {
      //Determine which tweet to display
      if (tweet.quoteStatus == true) {
        tweetText?.text = tweet.quotedTweet
        profileUsername?.text = "@\(tweet.quotedUser?.screenName)"
        profileName?.text = tweet.quotedUser?.name
      } else if(tweet.retweetBool == true) {
        tweetText?.text = tweet.retweetOriginalText
        profileUsername?.text = "@\(tweet.retweetUser?.screenName)"
        profileName?.text = tweet.retweetUser?.name
      }else {
        tweetText?.text = tweet.text
        profileUsername?.text = "@\(tweet.username)"
        profileName?.text = tweet.name
      }
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
