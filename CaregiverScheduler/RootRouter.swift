//
//  RootRouter.swift
//  MangaPocket
//
//  Created by Jean Raphael on 20/07/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import UIKit

struct RootRouter {
    
    static func presentRootViewController(in window: UIWindow) {
        window.makeKeyAndVisible()
        
        window.rootViewController = CaregiverSchedulerRoot().assembleModule()
    }
    
}
