//
//  Profile.swift
//  bike app prod
//
//  Created by Денис Наумов on 23.09.2021.
//  Copyright © 2021 Денис Наумов. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var balanceButton: UIButton!
    @IBOutlet weak var discountView: UIView!

    func setupUserProfile(with model: ProfileModel) {
        profileImageView.image = UIImage(named: model.imageName)
        usernameLabel.text = model.username
        balanceButton.titleLabel?.text = "$ \(model.balance)"
    }
}

struct ProfileModel {
    var imageName: String
    var username: String
    var balance: Int
}
