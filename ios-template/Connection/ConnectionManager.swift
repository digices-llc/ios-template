//
//  ConnectionManager.swift
//  Connection
//
//  Created by Roderic Linguri <linguri@digices.com>
//  License: MIT
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

// MARK: - Class

class ConnectionManager {
  
  // MARK: - Properties
  
  var delegate: ConnectionManagerDelegate
  
  // MARK: - Methods
  
  /**
   * Create a ConnectionManager instance with a delegate
   * - parameter: delegate to receive notifications
   */
  init(delegate: ConnectionManagerDelegate) {
    self.delegate = delegate
  }
  
  /**
   * Receive completion of URLSession Task on background queue
   * - parameter: optional Data (body of the response)
   * - parameter: optional URLResponse (contains response codes, etc.)
   * - parameter: optional Error (Server Error, not-found etc.)
   */
  func completionHandler(data: Data?, response: URLResponse?, error: Error?) {
    if let e = error {
      OperationQueue.main.addOperation { [weak self] in
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let weakSelf = self {
          weakSelf.delegate.connectionManager(weakSelf, didProduceError: e)
        } // ./unwrap self
      } // ./main queue
    } // ./unwrap error
    
    if let d = data {
      
      OperationQueue.main.addOperation {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        do {
          let object = try JSONSerialization.jsonObject(with: d, options: .allowFragments)
          self.delegate.connectionManager(self, didReceiveObject: object)
        }
          
        catch {
          if let string = String(data: d, encoding: .utf8) {
            self.delegate.connectionManager(self, didReceiveString: string)
          } else {
            self.delegate.connectionManager(self, didProduceError: ConnectionError.unrecognizedData)
          }
        }
        
      } // ./main queue
    } // ./unwrap data
    
  } // ./completionHandler
  
  /**
   * Send a connection request
   * - parameter: a Connection object
   */
  func sendRequest(forConnection connection: Connection) {
    if let request = connection.request {
      let task = URLSession.shared.dataTask(with: request, completionHandler: self.completionHandler)
      task.resume()
      OperationQueue.main.addOperation {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      }
    } // ./we have a request
      
    else {
      self.delegate.connectionManager(self, didProduceError: ConnectionError.requestCreationError)
    } // ./request was nil
    
  } // ./sendRequest
  
} // ./ConnectionManager
