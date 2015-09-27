//
//  TwitterService.swift
//  TwitterCF
//
//  Created by Jeffrey Jacka on 8/4/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import UIKit
import Accounts
import Social

class TwitterService {
  
  static let SharedService = TwitterService()
  
  var account : ACAccount?
  var user : User?
  var backgroundImages = [String: UIImage]()
  var profileImages = [String : UIImage]()
  
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
        print("AuthUser Data Error")
      } else {
        switch response.statusCode {
        case 200...299:
          do {
            if let userData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject]{
              let user = TweetJSONParser.userFromData(userData)
              TwitterService.SharedService.user = user
            }
          } catch {
            //handle error here
          }
        case 400...499:
          print("400..499 error Status code:\(response.statusCode)")
        case 500...599:
          print("500..599 error")
        default:
          print("Unknown get user error")
        }
        
      }
    }
  }
  
  //Refresh New Tweets
  class func refreshNewTweets(sinceId : String, completion: (String?, [Tweet]?) -> () ) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: ["since_id":sinceId])
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
  
  //Grab Old Tweets
  class func refreshOldTweets(maxId : String, completion: (String?, [Tweet]?) -> () ) {
    
    
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: ["max_id":maxId])
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
  
}