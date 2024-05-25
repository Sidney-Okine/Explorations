//
//  ViewController.swift
//  Perfection 2.0
//
//  Created by Sidney Okine on 28/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = TableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }


}



