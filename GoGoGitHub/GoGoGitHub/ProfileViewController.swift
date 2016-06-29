//
//  ProfileViewController.swift
//  GoGoGitHub
//
//  Created by Erin Roby on 6/29/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: class { // naming convention from Apple
    func profileViewControllerDidFinish() // this is a naming convention from Apple
}

class ProfileViewController: UIViewController, Setup {
    
    @IBOutlet weak var closeButton: UIButton!
    weak var delegate: ProfileViewControllerDelegate?
    
    
    @IBAction func closeButtonSelected(sender: UIButton) {
        // profile view has to have a way to tell it's parent controller that it needs to be dismissed.
        self.delegate?.profileViewControllerDidFinish()
    }

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        API.shared.GETUser( { (user) in
            if let user = user {
                self.nameLabel.text = user.name
                self.locationLabel.text = user.location
            }
        })
    }
    
    func setupAppearance() {
        self.closeButton.layer.cornerRadius = 3.0
    }

}
