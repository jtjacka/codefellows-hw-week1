//
//  UserTimeLineViewController.swift
//  
//
//  Created by Jeffrey Jacka on 8/6/15.
//
//

import UIKit

class UserTimeLineViewController: UIViewController {
  
  var tweet : Tweet?
  var tweets : [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")

        // Do any additional setup after loading the view.
        
        TwitterService.tweetsFromOtherTimeLine(tweet!.username) { (error, tweets) -> () in
          if let error = error {
            
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
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserTimeLineViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }else {
            return 1
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        if let tweets = tweets {
            let tweet = tweets[indexPath.row]
            
            cell.tweetText?.text = tweet.text
            cell.profileName?.text = "@\(tweet.username)"
            cell.profileUsername?.text = tweet.name
            cell.profileImage?.setImage(tweet.getprofileImage(), forState: .Normal)
        }
        
        
        return cell
    }
    
    
}
