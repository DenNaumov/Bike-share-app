//
//  ViewController.swift
//  Bike App
//
//  Created by Денис Наумов on 23.08.2020.
//  Copyright © 2020 Денис Наумов. All rights reserved.
//

import UIKit
import SwiftUI

class IdentifyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Настройки",
            style: .plain,
            target: self,
            action: #selector(openSettings)
        )
    }

    @objc private func openSettings() {
        let settingsView = SettingsView(onDismiss: { [weak self] in
            self?.dismiss(animated: true)
        })
        let hosting = UIHostingController(rootView: settingsView)
        present(hosting, animated: true)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    @IBAction func didTapRegisterButton() {
    }

    @IBAction func didTapLoginButton() {
    }
}
