//
//  HomeViewController.swift
//  GoGoGitHub
//
//  Created by Erin Roby on 6/28/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class HomeViewController: UIViewController, Setup, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var transition = CustomModalTransition(duration: 2.0)
    
=======
class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
>>>>>>> 781010de0681a2a107aa14b154bc92b3f9d1b877
    var repositories = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
=======
//        API.shared.GETRepositories()
>>>>>>> 781010de0681a2a107aa14b154bc92b3f9d1b877
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
<<<<<<< HEAD
    
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
    
=======
}

extension HomeViewController: UITableViewDataSource {
>>>>>>> 781010de0681a2a107aa14b154bc92b3f9d1b877
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let repositoryCell = tableView.dequeueReusableCellWithIdentifier("repositoryCell", forIndexPath: indexPath)
        let respository = self.repositories[indexPath.row]
        repositoryCell.textLabel?.text = respository.name
        return repositoryCell
    }
<<<<<<< HEAD
    
    func profileViewControllerDidFinish() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
=======
>>>>>>> 781010de0681a2a107aa14b154bc92b3f9d1b877
}
