//
//  Coordinator.swift
//  Albums
//
//  Created by Sujan Kanna on 5/28/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import UIKit
import Foundation

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
