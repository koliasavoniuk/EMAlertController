//
//  EMAlertAction.swift
//  EMAlertController
//
//  Created by Eduardo Moll on 10/14/17.
//  Copyright © 2017 Eduardo Moll. All rights reserved.
//

import UIKit

@objc public enum EMAlertActionStyle: Int {
  case normal
  case cancel
  case boldBlue
}

/// An action that can be taken when the user taps a button in an EMAlertController
open class EMAlertAction: UIButton {
  
  // MARK: - Properties
  internal var action: (() -> Void)?
  
  @objc public var title: String? {
    willSet {
      setTitle(newValue, for: .normal)
    }
  }
  
  @objc public var titleColor: UIColor? {
    willSet {
      setTitleColor(newValue, for: .normal)
    }
  }
  
  @objc public var titleFont: UIFont? {
    willSet {
      self.titleLabel?.font = newValue
    }
  }
  
  @objc public var actionBackgroundColor: UIColor? {
    willSet {
      backgroundColor = newValue
    }
  }

  // MARK: - Initializers
  required public  init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public init(title: String, titleColor: UIColor) {
    super.init(frame: .zero)
    
    self.setTitle(title, for: .normal)
    self.setTitleColor(titleColor, for: .normal)
  }
  
  @objc public convenience init(title: String, style: EMAlertActionStyle, action: (() -> Void)? = nil) {
    self.init(type: .system)
    
    self.action = action
    self.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)

    switch style {
      case .normal:
        setTitle(title: title, forStyle: .normal)
      case .cancel:
        setTitle(title: title, forStyle: .cancel)
      case .boldBlue:
        setTitle(title: title, forStyle: .boldBlue)
    }
  }
}

internal extension EMAlertAction {
  
  fileprivate func setTitle(title: String, forStyle: EMAlertActionStyle) {
    self.setTitle(title, for: .normal)
    addSeparator()

    switch forStyle {
    case .normal:
      //setTitleColor(UIColor.emActionColor, for: .normal)
      setTitleColor(#colorLiteral(red: 0.2431372549, green: 0.4666666667, blue: 0.6666666667, alpha: 1), for: .normal)
      titleFont = UIFont.systemFont(ofSize: 17)
      
    case .cancel:
      setTitleColor(UIColor.emCancelColor, for: .normal)
      titleFont = UIFont.systemFont(ofSize: 17)
    case .boldBlue:
        setTitleColor(#colorLiteral(red: 0.2431372549, green: 0.4666666667, blue: 0.6666666667, alpha: 1), for: .normal)
        titleFont = UIFont.boldSystemFont(ofSize: 17)
    }
  }
  
  fileprivate func addSeparator() {
    let separator = UIView()
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.backgroundColor = UIColor.emSeparatorColor.withAlphaComponent(0.4)
    
    self.addSubview(separator)
    
    separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    separator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    separator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    separator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
  }
  
  @objc func actionTapped(sender: EMAlertAction) {
    self.action?()
  }
}
