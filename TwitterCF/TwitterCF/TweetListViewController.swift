//
//  ViewController.swift
//  TwitterCF
//
//  Created by Jeffrey Jacka on 8/3/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import UIKit

class TweetListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var tweets = [Tweet]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Register Xib
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
    
   
    
    
    LoginService.loginForTwitter { (error, account) -> (Void) in
      if let error = error {
        println(error)
      } else {
        if let account = account {
          TwitterService.SharedService.account = account
          TwitterService.getAuthUserData()
          TwitterService.tweetsFromHomeTimeline({ (error, tweets) -> () in
            if let error = error {
              println(error)
            } else {
              if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                  self.tweets = tweets
                  self.tableView.reloadData()
                })
              }
            }
          })
          
        }
        
      }
    }
    
    tableView.dataSource = self
    tableView.delegate = self
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //Followed guide here:
  //http://www.codingexplorer.com/segue-uitableviewcell-taps-swift/
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowTweetDetail" {
      if let destination = segue.destinationViewController as? TweetDetailViewController {
        if let tweetIndex = tableView.indexPathForSelectedRow()?.row {
          destination.tweet = tweets[tweetIndex]
        }
      }
    } else if segue.identifier == "ShowProfile" {
      if let destination = segue.destinationViewController as? UserTimeLineViewController {
        if let tweetIndex = tableView.indexPathForSelectedRow()?.row {
          //set which user to send to profile
        }
      }
    }
  }
  
}


extension TweetListViewController : UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  
  
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    
    let tweet = tweets[indexPath.row]
    
    cell.tweetText?.text = tweet.text
    cell.profileUsername?.text = "@\(tweet.user.screenName)"
    cell.profileName?.text = tweet.user.name
    cell.profileImage?.setImage(tweet.getprofileImage(), forState: .Normal)
    
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    
    
    return cell
  }
  

}

extension TweetListViewController : UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowTweetDetail", sender: self)
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
  }
}
