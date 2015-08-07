//
//  TwitterService.swift
//  TwitterCF
//
//  Created by Jeffrey Jacka on 8/4/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  static let SharedService = TwitterService()
  
  var account : ACAccount?
  var lastRefreshTime : Double?
  var oldRefreshTime : Double?
  var user : User?
  
  private init() {}
  
  //Tweets from Home Timeline
  class func tweetsFromHomeTimeline(completion: (String?, [Tweet]?) -> () ) {
   let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
    request.account = self.SharedService.account
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        //Execute completion handler
          completion("Request Error", nil)
      } else {
        switch response.statusCode {
        case 200...299:
            let tweets = TweetJSONParser.TweetFromJSONData(data)
            completion(nil, tweets)
        case 400...499:
          completion("This is our fault", nil)
        case 500...599:
          completion("This is the server's fault", nil)
        default:
            completion("Error", nil)
        }
        
        }
      }
    }
  
  //Tweets from other User Timeline
  class func tweetsFromOtherTimeLine(username : String, completion: (String?, [Tweet]?) -> () ) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(username)"), parameters: nil)
    request.account = self.SharedService.account
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        //Execute completion handler
        completion("Request Error", nil)
      } else {
        println("Tweets from other time line response code \(response.statusCode)")
        switch response.statusCode {
        case 200...299:
          let tweets = TweetJSONParser.TweetFromJSONData(data)
          completion(nil, tweets)
        case 400...499:
          completion("This is our fault", nil)
        case 500...599:
          completion("This is the server's fault", nil)
        default:
          completion("Error", nil)
        }
        
      }
    }
  }
    
    //Get Authenticated User Data
    class func getAuthUserData() {
        
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        request.account = self.SharedService.account
        
        request.performRequestWithHandler { (data, response, error) -> Void in
            if let error = error {
                //Execute completion handler
                println("AuthUser Data Error")
            } else {
                switch response.statusCode {
                case 200...299:
                    var error : NSError?
                    if let userData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject]{
                        let user = TweetJSONParser.userFromData(userData)
                      TwitterService.SharedService.user = user
                    }
                case 400...499:
                    println("400..499 error Status code:\(response.statusCode)")
                case 500...599:
                    println("500..599 error")
                default:
                    println("Unknown get user error")
                }
                
            }
        }
    }
  
  //Get User Banner
  
  
  //Refresh New Tweets
  class func refreshNewTweets() {
    
  }
  
  //Grab Old Tweets
  class func refreshOldTweets() {
    
  }
  
  }