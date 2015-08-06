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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      if let tweets = tweets {
        TwitterService.tweetsFromOtherTimeLine(tweet!.username) { (error, tweets) -> () in
          if let error = error {
            
          } else  {
            if let tweets = tweets {
              NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.tweets = tweets
              })
            }
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
