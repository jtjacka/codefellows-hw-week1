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
                profileImageURL = user["profile_image_url"] as? String,
                username = user["screen_name"] as? String{
                  
                  
                  //Add Retweet Data for Quoted Tweets
                  if let retweetObject  = tweetObject["retweeted_status"] as? [String : AnyObject] {
                    let retweetedBool = true
                    if let retweetText = retweetObject["text"] as? String,
                      retweetUser = retweetObject["user"] as? [String : AnyObject] {
                        if let retweetUsername = retweetUser["name"] as? String,
                          retweetName = retweetUser["screen_name"] as? String,
                        retweetProfileURL = retweetUser["profile_image_url"] as? String {
                          let newTweet =  Tweet(text: text, username: username, name: name, id: id, profileImageURL: profileImageURL, profileImage: nil, retweetBool: retweetedBool, retweetOriginalText: retweetText, retweetOriginalUsername: retweetUsername, reweetOriginalName: retweetName,retweetOrginalURL : retweetProfileURL, quoteStatus: nil, quotedTweet: nil, quotedOriginalUsername: nil, quotedOriginalName: nil,  quotedOriginalURL : nil)
                            tweets.append(newTweet)
                        }
                    }
                  } else if let quoteStatus = tweetObject["is_quote_status"] as? Bool where quoteStatus == true {
                      if let quoteData = tweetObject["quoted_status"] as? [String : AnyObject] {
                        if let quoteText = quoteData["text"] as? String,
                          let quoteUser = quoteData["user"] as? [String : AnyObject] {
                            if let quoteName = quoteUser["name"] as? String,
                              let quoteUsername = quoteUser["screen_name"] as? String,
                            quoteProfileURL = quoteUser["profile_image_url"] as? String{
                                let newTweet =  Tweet(text: text, username: username, name: name, id: id, profileImageURL: profileImageURL, profileImage: nil, retweetBool: nil, retweetOriginalText: nil, retweetOriginalUsername: nil, reweetOriginalName: nil, retweetOrginalURL : nil,quoteStatus: quoteStatus, quotedTweet: quoteText, quotedOriginalUsername: quoteUsername, quotedOriginalName: quoteName,  quotedOriginalURL : quoteProfileURL)
                                tweets.append(newTweet)
                            }
                        }
                        
                      }
                    } //Add Retweet Data for Retweeted Tweets
                    else {
                    
                    //Neither Retweet or Quote
                    let newTweet = Tweet(text: text, username: username, name: name, id: id, profileImageURL: profileImageURL, profileImage: nil, retweetBool: nil, retweetOriginalText: nil, retweetOriginalUsername: nil, reweetOriginalName: nil,retweetOrginalURL : nil, quoteStatus: nil, quotedTweet: nil, quotedOriginalUsername: nil, quotedOriginalName: nil,  quotedOriginalURL : nil)
                    
                    tweets.append(newTweet)
                  }
                  
                  
                  
                  
                  
              }
          }
        }
        return tweets
    }
    
    
    return nil
  }
}