//
//  ViewController.swift
//  bikeapp
//
//  Created by Денис Наумов on 23.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapStartButton() {

        guard let nextViewController = storyboard?.instantiateViewController(identifier: "nameVC") as? NameViewController else { return }
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}
