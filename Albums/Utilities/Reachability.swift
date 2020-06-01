//
//  Reachability.swift
//  Albums
//
//  Created by Sujan Kanna on 5/30/20.
//  Copyright © 2020 Exercise. All rights reserved.
//

import Foundation
import SystemConfiguration

class Reachability {
    
    func isNetworkReachable() -> Bool {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.google.com") else { return false }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        return flags.contains(.reachable)
    }
}
