//
//  TweetJSONParser.swift
//  TwitterCF
//
//  Created by Jeffrey Jacka on 8/3/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation

class TweetJSONParser {
  class func TweetFromJSONData(jsonData: NSData) -> [Tweet]? {
    
    var error : NSError?
    
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(
      jsonData, options: nil, error: &error) as? [[String : AnyObject]] {
        
        
        var tweets = [Tweet]()
        
        println(rootObject.count)
        
        for tweetObject in rootObject {
              if let text = tweetObject["text"] as? String,
                      id  = tweetObject["id_str"] as? String,
                user = tweetObject["user"] as? [String : AnyObject] {
                  if let name = user["name"] as? String,
                    profileImageURL = user["profile_image_url"] as? String {
                      let newTweet = Tweet(text: text, username: name, id: id, profileImageURL: profileImageURL)
                      tweets.append(newTweet)
                  }
            }
        }
        return tweets
    }
    
    
    return nil
  }
}