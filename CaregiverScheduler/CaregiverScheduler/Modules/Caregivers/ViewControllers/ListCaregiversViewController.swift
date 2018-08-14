//
//  ListCaregiversViewController.swift
//  CaregiverScheduler
//
//  Created by Jean Raphael on 14/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import SwiftSpinner
import Kingfisher

class ListCaregiversViewController: UIViewController {
    private let bag = DisposeBag()

    @IBOutlet var tableView: UITableView!
    
    // MARK: - Dependencies

    final var viewModel: CaregiversViewModel!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func refreshTap(_ sender: Any) {
        viewModel
            .fetchCaregivers
            .execute(true)
    }
    
    // MARK: - Privates
    
    private func bindUI() {
        
        tableView.rowHeight = 110
        
        SwiftSpinner.show(NSLocalizedString("Loading ...", comment: "Loading"))
        
        // Table view
        viewModel
            .fetchCaregivers
            .elements
            .bind(to: tableView.rx.items(cellIdentifier: "CaregiverCell", cellType: CaregiverCell.self)) { index, model, cell in
                cell.nameLabel.text = model.name.first.capitalized
                cell.surnameLabel.text = model.name.last.capitalized
                
                if let url = model.imageUrl() {
                    cell.thumbnail?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, URL in
                        cell.setNeedsLayout()
                    })
                }
                
            }
            .disposed(by: bag)
        
        // Spinner
        viewModel
            .fetchCaregivers
            .executing
            .bind(to: SwiftSpinner.sharedInstance.rx_visible)
            .disposed(by: bag)
        
        // Execution
        viewModel
            .fetchCaregivers
            .execute(true)
    }

}

class CaregiverCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var surnameLabel: UILabel!
}
