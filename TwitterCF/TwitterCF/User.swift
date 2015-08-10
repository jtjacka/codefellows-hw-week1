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
    var newUrl = self.profileImageURL.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    
    var imageURL = NSURL(string: newUrl)
    
    
    if let imageURL = imageURL {
      if let imageData = NSData(contentsOfURL: imageURL),
        image = UIImage(data: imageData) {
            //Resize Image
        var resizedImage = ImageResizer.resizeImage(image)
            
            return resizedImage
      }
      
    }
    
    return nil
  }
  
  func getBackgroundImage() -> UIImage? {
    var image : UIImage
    
    var imageURL = NSURL(string: self.profileBackgroundURL)
    if let imageURL = imageURL {
      if let imageData = NSData(contentsOfURL: imageURL),
        image = UIImage(data: imageData) {
          return image
      }
      
    }
    
    return nil
  }
  
}
