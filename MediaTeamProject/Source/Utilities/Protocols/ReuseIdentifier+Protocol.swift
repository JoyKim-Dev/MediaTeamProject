//
//  ReuseIdentifier+Protocol.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/10/24.
//

import UIKit

protocol ReuseIdentifierProtocol: AnyObject {
    
    static var identifier: String {get}
}

extension UIView: ReuseIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}
