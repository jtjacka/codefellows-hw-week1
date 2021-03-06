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
    do {
      if let rootObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [[String : AnyObject]] {
        
        var tweets = [Tweet]()
        
        print(rootObject.count)
        
        for tweetObject in rootObject {
          if let text = tweetObject["text"] as? String,
            id  = tweetObject["id_str"] as? String,
            user = tweetObject["user"] as? [String : AnyObject] {
              
              if let user = userFromData(user) {
                //Add Retweet Data for Quoted Tweets
                if let retweetObject  = tweetObject["retweeted_status"] as? [String : AnyObject] {
                  let retweetedBool = true
                  if let retweetText = retweetObject["text"] as? String,
                    retweetUser = retweetObject["user"] as? [String : AnyObject] {
                      
                      let retweetUser = userFromData(retweetUser)
                      
                      let newTweet =  Tweet(text: text, id: id, user: user, retweetBool: retweetedBool, retweetOriginalText: retweetText, retweetUser: retweetUser, quoteStatus: nil, quotedTweet: nil, quotedUser : nil)
                      tweets.append(newTweet)
                      
                  }
                } else if let quoteStatus = tweetObject["is_quote_status"] as? Bool where quoteStatus == true {
                  if let quoteData = tweetObject["quoted_status"] as? [String : AnyObject] {
                    if let quoteText = quoteData["text"] as? String,
                      let quoteUser = quoteData["user"] as? [String : AnyObject] {
                        
                        let quotedUser = userFromData(quoteUser)
                        
                        let newTweet =  Tweet(text: text, id: id, user: user, retweetBool: nil, retweetOriginalText: nil, retweetUser: nil,quoteStatus: quoteStatus, quotedTweet: quoteText, quotedUser: quotedUser)
                        tweets.append(newTweet)
                    }
                  }
                  
                } //Add Retweet Data for Retweeted Tweets
                else {
                  
                  //Neither Retweet or Quote
                  let newTweet = Tweet(text: text, id: id, user: user, retweetBool: nil, retweetOriginalText: nil, retweetUser: nil, quoteStatus: nil, quotedTweet: nil, quotedUser : nil)
                  
                  tweets.append(newTweet)
                }
              }
          }
        }
        return tweets
      }
    } catch {
      //Error Catching Here
      return nil;
    }
    
    return nil;
  }
  
  class func userFromData(user : [String : AnyObject]) -> User? {
    if let name = user["name"] as? String,
      userName = user["screen_name"] as? String,
      profileImageURL = user["profile_image_url"] as? String,
      profileBackgroundURL = user["profile_banner_url"] as? String,
      id = user["id_str"] as? String{
        return User(id: id, name: name, screenName: userName, profileImageURL: profileImageURL, profileBackgroundURL: profileBackgroundURL)
    }
    
    return nil
  }
}