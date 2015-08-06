//
//  Tweet.swift
//  TwitterCF
//
//  Created by Jeffrey Jacka on 8/3/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation
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
  let retweetOriginalUsername : String?
  let reweetOriginalName : String?
  let retweetOrginalURL : String?
  let quoteStatus : Bool?
  let quotedTweet : String?
  let quotedOriginalUsername : String?
  let quotedOriginalName : String?
  let quotedOriginalURL : String?
  
  func getprofileImage() -> UIImage? {
    var image : UIImage
    
    var imageURL = NSURL(string: self.profileImageURL)
    if let imageURL = imageURL {
      NSURLRequest(URL: imageURL)
      
    }
    
    return nil
  }

  
}



