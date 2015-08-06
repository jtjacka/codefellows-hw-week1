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
  class func tweetsFromHomeTimeline(account : ACAccount, completion: (String?, [Tweet]?) -> () ) {
   let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
    request.account = account
    
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