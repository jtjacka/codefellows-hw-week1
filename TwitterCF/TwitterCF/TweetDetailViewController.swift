//
//  TweetDetailViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/5/15.
//
//

import UIKit

class TweetDetailViewController: UIViewController {


  @IBOutlet weak var profileUsername: UILabel!
  @IBOutlet weak var tweetText: UILabel!
  @IBOutlet weak var profileName: UILabel!
  @IBOutlet weak var profileImage: UIButton!
  @IBOutlet weak var tableView: UITableView!
  
  var tweet : Tweet?
  var tweets = [Tweet]()
  var user : User?
  
  
  override func viewWillAppear(animated: Bool) {

    
    //Fix Back Button Text
    //Cofingure NavBar Back Button
    //Borrow from Team Treehouse course
    if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
      let barButtonAttributesDictionary: [String: AnyObject]? = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: buttonFont
      ]
      UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
      
    }
    
    
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
    
    
    if let tweet = tweet {
      //Determine which tweet to display
      if (tweet.quoteStatus == true) {
        if let user = tweet.quotedUser {
          
          //Grab TimeLine from Quoted User
          TwitterService.tweetsFromOtherTimeLine(user.screenName, completion: { (errorText, tweets) -> () in
            if let tweets = tweets {
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.tweets = tweets
                self.user = user
                self.tableView.reloadData()
              })
            }
          })
          
          
          tweetText?.text = tweet.quotedTweet
          profileUsername?.text = "@\(tweet.user.screenName)"
          profileName?.text = user.name
          profileImage?.setImage(user.getprofileImage(), forState: .Normal)
        }
      } else if(tweet.retweetBool == true) {
        if let user = tweet.retweetUser {
          
          //Grab Timeline for Retweet User
          TwitterService.tweetsFromOtherTimeLine(user.screenName, completion: { (errorText, tweets) -> () in
            if let tweets = tweets {
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.tweets = tweets
                self.user = user
                self.tableView.reloadData()
              })

            }
          })
          
          tweetText?.text = tweet.retweetOriginalText
          profileUsername?.text = "@\(user.screenName)"
          profileName?.text = user.name
          profileImage?.setImage(user.getprofileImage(), forState: .Normal)
        }
      }else {
        
        //Grab Timeline for User
        TwitterService.tweetsFromOtherTimeLine(tweet.user.screenName, completion: { (errorText, tweets) -> () in
          if let tweets = tweets {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.tweets = tweets
              self.user = tweet.user
              self.tableView.reloadData()
            })

          }
        })
        
        
        tweetText?.text = tweet.text
        profileUsername?.text = "@\(tweet.user.screenName)"
        profileName?.text = tweet.user.name
        profileImage?.setImage(tweet.user.getprofileImage(), forState: .Normal)
      }
      
      
    }
    
        tableView.dataSource = self

    
        // Do any additional setup after loading the view.
    }

  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowProfile" {
      if let destination = segue.destinationViewController as? UserTimeLineViewController {
          destination.tweets = tweets
          destination.user = user
      }
    }
  }

}

extension TweetDetailViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
    
    let tweet = tweets[indexPath.row]
    
    cell.tweetText?.text = tweet.text
    cell.profileUsername?.text = "@\(tweet.user.screenName)"
    cell.profileName?.text = tweet.user.name
    cell.profileImage?.setImage(tweet.user.getprofileImage(), forState: .Normal)
    
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
    
    
    return cell
  }
  
  
}
