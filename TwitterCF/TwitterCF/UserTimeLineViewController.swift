//
//  UserTimeLineViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/6/15.
//
//

import UIKit

class UserTimeLineViewController : UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var backgroundImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var username: UILabel!
  
  
  var user : User?
  var tweets : [Tweet] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
      
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
      if let user = TwitterService.SharedService.user {
        profileImage.image = user.getprofileImage()
        backgroundImage.image = user.getBackgroundImage()
        name.text = user.name
        username.text = "@\(user.screenName)"
        
        
        TwitterService.tweetsFromOtherTimeLine(user.screenName) { (error, tweets) -> () in
          if let error = error {
            //meh
          } else  {
            if let tweets = tweets {
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.tweets = tweets
                self.tableView.reloadData()
              })
            }
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

extension UserTimeLineViewController : UITableViewDataSource {
  
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
