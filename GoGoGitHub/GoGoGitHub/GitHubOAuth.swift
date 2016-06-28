//
//  GitHubOAuth.swift
//  GoGoGitHub
//
//  Created by Erin Roby on 6/27/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

let kAccessTokenKey = "kAccessTokenKey"
let kOAuthBaseURLString = "https://github.com/login/oauth/"
let kAccessTokenRegexPattern = "access_token=([^&]+)"

typealias GitHubOAuthCompletion = (success: Bool) -> ()

enum GitHubOAuthError: ErrorType {
    case MissingAccessToken(String)
    case ExtractingTokenFromString(String)
    case ExtractingTemporaryCode(String)
    case ResponseFromGitHub(String)
}

enum SaveOptions: Int {
    case userDefaults
}

class GitHubOAuth {
    static let shared = GitHubOAuth()
    private init(){}
    
    func oAuthRequestWith(parameters: [String: String]) {
        
        var parametersString = String()
        
        for parameter in parameters.values {
            parametersString = parametersString.stringByAppendingString(parameter)
        }
        
        if let requestURL = NSURL(string: "\(kOAuthBaseURLString)authorize?client_id=\(kGitHubClientID)&scope=\(parametersString)") {
            print(requestURL)
            UIApplication.sharedApplication().openURL(requestURL)
        }
    }
    
    func temporaryCodeFromCallback(url: NSURL) throws -> String {
        print("Callback URL: \(url.absoluteString)")
        
        guard let temporaryCode = url.absoluteString.componentsSeparatedByString("=").last else {
            throw GitHubOAuthError.ExtractingTemporaryCode("Error Extracting Temporary Code from Callback URL.")
        }
        
        print("Temp Code: \(temporaryCode)")
        return temporaryCode
    }
    
    func stringWithData(data: NSData) -> String? {
        let byteBuffer: UnsafeBufferPointer<UInt8> = UnsafeBufferPointer<UInt8>(start: UnsafeMutablePointer<UInt8>(data.bytes), count: data.length)
        let result = String(bytes: byteBuffer, encoding: NSASCIIStringEncoding)
        return result
    }
    
    func accessTokenFromString(string: String) throws -> String? {
        do {
            let regex = try NSRegularExpression(pattern: kAccessTokenRegexPattern, options: NSRegularExpressionOptions.CaseInsensitive)
            print("\(string)")
            let matches = regex.matchesInString(string, options: .Anchored, range: NSMakeRange(0, string.characters.count))
            print("\(matches)")
            if matches.count > 0 {
                for(_, value) in matches.enumerate() {
                    let matchRange = value.rangeAtIndex(1)
                    return (string as NSString).substringWithRange(matchRange)
                }
            }
        } catch _ {
            throw GitHubOAuthError.ExtractingTokenFromString("Could not extract token from string.")
        }
        return nil
    }
    
    func saveAccessTokenToUser(accessToken: String) -> Bool {
        NSUserDefaults().setObject(accessToken, forKey: kAccessTokenKey)
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func tokenRequestWithCallback(url: NSURL, options: SaveOptions, completion: GitHubOAuthCompletion) {
        do {
            let temporaryCode = try self.temporaryCodeFromCallback(url)
            let requestString = "\(kOAuthBaseURLString)access_token?client_id=\(kGitHubClientID)&client_secret=\(kGitHubClientSecret)&code=\(temporaryCode)"
            
            if let requestURL = NSURL(string: requestString) {
                let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
                let session = NSURLSession(configuration: sessionConfiguration)
                session.dataTaskWithURL(requestURL, completionHandler: { (data, response, error) in
                    if let _ = error {
                        NSOperationQueue.mainQueue().addOperationWithBlock({
                            completion(success: false)
                            return
                        })
                    }
                    
                    if let data = data {
                        if let tokenString = self.stringWithData(data) {
                            print(data)
                            do {
                                if let token = try self.accessTokenFromString(tokenString){
                                    print("token: \(token)")
                                    NSOperationQueue.mainQueue().addOperationWithBlock({ completion(success: self.saveAccessTokenToUser(token))
                                        
                                    })
                                }
                            } catch _ {
                                NSOperationQueue.mainQueue().addOperationWithBlock({ completion(success: false)
                                })
                            }
                        }
                    }
                }).resume()
            }
        } catch _ {
            NSOperationQueue.mainQueue().addOperationWithBlock({ completion(success: false) })
        }
    }
    
    func accessToken() throws -> String? {
        guard let accessToken = NSUserDefaults.standardUserDefaults().stringForKey(kAccessTokenKey) else {
            throw GitHubOAuthError.MissingAccessToken("There is no Access Token saved.")
        }
        
        return accessToken
    }
}










































