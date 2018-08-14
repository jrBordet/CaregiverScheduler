//
//  MangaRoot.swift
//  MangaPocket
//
//  Created by Jean Raphael on 20/07/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import UIKit

class CaregiverSchedulerRoot {
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var navigation: UINavigationController!
    
    final func assembleModule() -> UIViewController {
        return createRootViewController()
    }
    
    // MARK: - Privates
    
    private func createRootViewController() -> UIViewController {
        return factoryListCaregivers()
    }
}

// MARK: - Factory methods

extension CaregiverSchedulerRoot {
    func factoryListCaregivers() -> UIViewController {
        let listCaregiversViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListCaregiversViewController") as! ListCaregiversViewController
        
        listCaregiversViewController.viewModel = CaregiversViewModel(input: (seed: "empatica", results: 100),
                                                                     dependecy: (dataManager: DataManager.shared, api: EmpaticaAPI()))
        
        navigation = UINavigationController(rootViewController: listCaregiversViewController)
        
        return navigation
    }
}
