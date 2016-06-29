//
//  HomeViewController.swift
//  GoGoGitHub
//
//  Created by Erin Roby on 6/28/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Setup, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var transition = CustomModalTransition(duration: 2.0)
    
    var repositories = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        API.shared.GETRepositories{ (repositories) in
            if let data = repositories {
                self.repositories = data
            }
        }
    }
    
    func setup() {
        self.navigationItem.title = "Repositories"
    }
    
    func setupAppearance() {
        //
    }
    
    @IBAction func AddButtonSelected(sender: AnyObject) {
        let controller = UIAlertController(title: "Create", message: "Please enter a name", preferredStyle: .Alert)
        let createAction = UIAlertAction(title: "Create", style: .Default) { (action) in
            guard let textField = controller.textFields?.first else { return }
            if let text = textField.text {
                API.shared.POSTRepository(text, completion: { (success) in
                    if success {
                        print("repo created...")
                    }
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        controller.addTextFieldWithConfigurationHandler(nil)
        controller.addAction(createAction)
        controller.addAction(cancelAction)
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource, ProfileViewControllerDelegate {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ProfileViewController.id {
            if let profileViewController = segue.destinationViewController as? ProfileViewController {
                profileViewController.delegate = self
                profileViewController.transitioningDelegate = self
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let repositoryCell = tableView.dequeueReusableCellWithIdentifier("repositoryCell", forIndexPath: indexPath)
        let respository = self.repositories[indexPath.row]
        repositoryCell.textLabel?.text = respository.name
        return repositoryCell
    }
    
    func profileViewControllerDidFinish() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
}
