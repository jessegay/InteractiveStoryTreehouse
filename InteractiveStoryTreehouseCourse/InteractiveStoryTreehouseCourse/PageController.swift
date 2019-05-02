//
//  PageController.swift
//  InteractiveStoryTreehouseCourse
//
//  Created by Jesse Gay on 5/1/19.
//  Copyright © 2019 Jesse Gay. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    var page: Page? //Pasan goes on at length explaining why this is an optional, even though we always require it, but the explanation was lost on me.
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    

}
