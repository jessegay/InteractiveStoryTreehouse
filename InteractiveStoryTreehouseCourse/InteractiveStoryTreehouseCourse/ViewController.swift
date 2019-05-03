//
//  ViewController.swift
//  InteractiveStoryTreehouseCourse
//
//  Created by Jesse Gay on 5/1/19.
//  Copyright © 2019 Jesse Gay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // this method is called on our ViewController subclass when the segue is fired off. By default it does nothing, but in a ViewController subclass we can use it to configure the DESTINATION ViewController prior to it being displayed. Every segue has a string identifier (by default it's blank) so select the segue, click on the Attributes inspector, and give it a name. Then we can refer to it specifically in subsequent methods.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            guard let pageController = segue.destination as? PageController else {
                return
            }
            pageController.page = Adventure.story
        }
    }
}

