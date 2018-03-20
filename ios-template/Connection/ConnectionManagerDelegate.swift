//
//  ConnectionManagerDelegate.swift
//  Connection
//
//  Created by Roderic Linguri <linguri@digices.com>
//  License: MIT
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

protocol ConnectionManagerDelegate {
  
  /**
   * Notify delegate with status of request
   * - parameter: ConnectionManager
   * - parameter: Bool (true)
   */
  func connectionManager(_ manager: ConnectionManager, statusOfRequest sent: Bool)
  
  /**
   * Notify delegate with an error
   * - parameter: ConnectionManager
   * - parameter: Error
   */
  func connectionManager(_ manager: ConnectionManager, didProduceError error: Error)
  
  /**
   * Notify delegate with a string
   * - parameter: ConnectionManager
   * - parameter: Bool (true)
   */
  func connectionManager(_ manager: ConnectionManager, didReceiveString string: String)
  
  /**
   * Did Receive Object
   * - parameter: ConnectionManager
   * - parameter: Any (deserialized JSON)
   */
  func connectionManager(_ manager: ConnectionManager, didReceiveObject object: Any)
  
} // ./ConnectionManagerDelegate
