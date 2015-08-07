//
//  Tweet.swift
//  TwitterCF
//
//  Created by Jeffrey Jacka on 8/3/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import UIKit

struct Tweet {
  let text : String
  let user : User
  let retweetBool : Bool?
  let retweetOriginalText : String?
  let retweetUser : User?
  let quoteStatus : Bool?
  let quotedTweet : String?
  let quotedUser : User?
  
  func getprofileImage() -> UIImage? {
    var image : UIImage
    
    var newUrl = self.user.profileImageURL.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    
    var imageURL = NSURL(string: newUrl)
    
    
    if let imageURL = imageURL {
      if let imageData = NSData(contentsOfURL: imageURL),
        image = UIImage(data: imageData) {
          return image
      }
      
    }
    
    return nil
  }
  
  
}



