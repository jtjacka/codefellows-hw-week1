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
    
    
    LoginService.loginForTwitter { (error, account) -> (Void) in
      if let error = error {
        println(error)
      } else {
        if let account = account {
          TwitterService.tweetsFromHomeTimeline(account, completion: { (error, tweets) -> () in
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
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}


extension TweetListViewController : UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! TweetCell
    
    let tweet = tweets[indexPath.row]
    
    cell.tweetText?.text = tweet.text
    cell.profileName?.text = "@\(tweet.username)"
    cell.profileUsername?.text = tweet.name
    
    
    return cell
  }
  

}
