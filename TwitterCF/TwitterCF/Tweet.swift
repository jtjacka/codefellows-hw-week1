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
  let username : String
  let name : String
  let id : String
  let profileImageURL : String
  var profileImage : UIImage?
  let retweetBool : Bool?
  let retweetOriginalText : String?
  let retweetUser : User?
  let quoteStatus : Bool?
  let quotedTweet : String?
  let quotedUser : User?
  
  func getprofileImage() -> UIImage? {
    var image : UIImage
    
    var imageURL = NSURL(string: self.profileImageURL)
    if let imageURL = imageURL {
      if let imageData = NSData(contentsOfURL: imageURL),
        image = UIImage(data: imageData) {
          return image
      }
      
    }
    
    return nil
  }
}



