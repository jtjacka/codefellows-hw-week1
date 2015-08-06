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
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?username=\(username)"), parameters: nil)
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
  
  //Refresh New Tweets
  class func refreshNewTweets() {
    
  }
  
  //Grab Old Tweets
  class func refreshOldTweets() {
    
  }
  
  }