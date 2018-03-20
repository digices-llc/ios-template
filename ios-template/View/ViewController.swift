//
//  ViewController.swift
//  ios-template
//
//  Created by Roderic Linguri <linguri@digices.com>
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Properties

  var keyboard: CGRect = CGRect.zero

  var keyboardIsVisible: Bool = false
  
  // MARK: - Outlets

  @IBOutlet weak var containerBottom: NSLayoutConstraint!
  
  // MARK: - Selectors

  @objc func notificationHandler(_ notification: Notification) {
    if let userInfo = notification.userInfo {
      if let screenFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
        let viewFrame = self.view.convert(screenFrame, from: UIScreen.main.coordinateSpace)
        if viewFrame.minY != self.keyboard.minY {
          self.keyboard = viewFrame
          let offset: CGFloat = self.view.bounds.height - viewFrame.minY
          if offset > 0 {
            self.keyboardIsVisible = true
          } else {
            self.keyboardIsVisible = false
          }
          self.containerBottom.constant = offset
          UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
          } // ./animate
        } // ./new frame is different than stored frame
      } // ./frame in userInfo
    } // ./have userInfo
  } // ./notificationHandler
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.notificationHandler(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
} // ./ViewController
