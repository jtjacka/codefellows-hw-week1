//
//  LoginService.swift
//  TwitterCF
//
//  Created by Jeffrey Jacka on 8/4/15.
//  Copyright (c) 2015 Jeffrey Jacka. All rights reserved.
//

import Foundation
import Accounts


class LoginService {
  class func loginForTwitter(completionHandler : (String?, ACAccount?) -> (Void)) {
    
    //Set Up Account Store
    let accountStore = ACAccountStore()
    //Give Account Store an account type (Twitter)
    let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
    
    //The end of this is a closure!
    accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
      //Trailing Closure
      if let error = error {
        completionHandler("Please Sign In!", nil)
      } else {
        if granted {
          if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
            completionHandler(nil, account)
          } else {
            completionHandler("Need permission to user twitter account", nil)
          }
        }
      }
    }
    
  }
  
}