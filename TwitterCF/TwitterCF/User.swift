//
//  User.swift
//  TwitterCF
//
//  Created by Jeff Jacka on 8/6/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import UIKit

struct User {
  
  let id : String
  let name : String
  let screenName : String
  let profileImageURL : String
  let profileBackgroundURL : String
  
  func getprofileImage() -> UIImage? {
    var image : UIImage
    //Grab full size image
    let newUrl = self.profileImageURL.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    
    let imageURL = NSURL(string: newUrl)
    
    if let image = TwitterService.SharedService.profileImages["\(newUrl)"] {
      return image
    } else {
      if let imageURL = imageURL {
        if let imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData) {
            //Resize Image
            let resizedImage = ImageResizer.resizeImage(image)
            
            //Add to resizedImage
            TwitterService.SharedService.profileImages["\(newUrl)"] = resizedImage
            
            return resizedImage
        }
        
      }
      
    }
    
    return nil
  }
  
  func getBackgroundImage() -> UIImage? {
    var image : UIImage
    
    let imageURL = NSURL(string: self.profileBackgroundURL)
    
    if let imageFromDict = TwitterService.SharedService.backgroundImages["\(self.profileBackgroundURL)"] {
      return imageFromDict
    } else {
      if let imageURL = imageURL {
        if let imageData = NSData(contentsOfURL: imageURL),
          image = UIImage(data: imageData) {
            
            //Add to Background Image Dictionary
            TwitterService.SharedService.backgroundImages["\(self.profileBackgroundURL)"] = image
            
            return image
        }
        
      }
    }
    
    return nil
  }
  
}
