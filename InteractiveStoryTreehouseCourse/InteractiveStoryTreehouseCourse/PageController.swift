//
//  PageController.swift
//  InteractiveStoryTreehouseCourse
//
//  Created by Jesse Gay on 5/1/19.
//  Copyright © 2019 Jesse Gay. All rights reserved.
//

import UIKit

// Note that we're putting this extension here rather than in the Story file because it's very specific to this page controller and how we use it. Seems odd to me but that's what he said.

extension NSAttributedString {
    var stringRange: NSRange {
        return NSMakeRange(0, self.length)
    }
}
extension Story {
    // Let's style the text. Need to create NSMutableAttributedString then modify its properties.
    var attributedText: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: attributedString.stringRange)
        
        return attributedString
        }
}

// This helper method allows us to chose whether we want a styled string or a plain string
extension Page {
    func story(attributed: Bool) -> NSAttributedString {
        if attributed {
            return story.attributedText
        } else {
            return NSAttributedString(string: story.text)
        }
    }
}




class PageController: UIViewController {
    
    var page: Page? //Pasan goes on at length explaining why this is an optional, even though we always require it, but the explanation was lost on me.
    
    // MARK: - User Interface Properties
    //Changing artworkView from let to lazy var allows us to access page even though it doesn't exist until the class is initialized (I'm fuzzy on this)
    lazy var artworkView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false // This overrides autolayouts inferred constraints.
        imageView.image = self.page?.story.artwork
        return imageView
    }()
    
    
    
    lazy var storyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // This allows the lines to wrap
        label.attributedText = self.page?.story(attributed: true)
        
        return label
    }()
    
    lazy var firstChoiceButton: UIButton = {
       let button = UIButton(type: .system)
       button.translatesAutoresizingMaskIntoConstraints = false
       //Let's use the nil coalescing operator! If value on left exists, use it, otherwise use value on right.
       let title = self.page?.firstChoice?.title ?? "Play Again"
        //and now let's try Ternary Conditional Operator! The Boolean check is on the left of ?, followed by the true case, then :, then the false case
       let selector = self.page?.firstChoice != nil ? #selector(PageController.loadFirstChoice) : #selector(PageController.playAgain)
       
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
       return button
    }()
    
    lazy var secondChoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(self.page?.secondChoice?.title, for: .normal)
        button.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)
        
        return button
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white // need to manually set this since the subsequent views are loading programmatically, rather than from a storyboard, which provides some default settings (such as a white background.)
    }
    
    // When ViewController's view is initialized, it checks to see if it has any subviews. It includes the viewWillLayoutSubviews method (or was it viewDidLayoutSubviews?), which, by default, does nothing, but we can override it to add subviews, that the View will create as it cycles through it's subview setup.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews() // notice we call the superclass first, and we've already called super.viewDidLoad()
        view.addSubview(artworkView) // This is how we add a subview..
        
        //  artworkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true // this sets the topAnchor of the artworkView subView to the topAnchor of the View, and makes it active. We could do this for every parameter, but it would get tedious. It's more efficient to use NSLayoutContraint.activate, and pass in an array of constraints. This is how we activate and constrain the subview we just added.
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])
        
        view.addSubview(storyLabel)
       
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
            ])
        
        view.addSubview(firstChoiceButton)
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
            ])
       
        view.addSubview(secondChoiceButton)
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
            ])
    }
    
    // Create helper methods to attach to buttons. Swift fix button added the @objc. Don't know why.
    @objc func loadFirstChoice() {
        if let page = page, let firstChoice = page.firstChoice {
            let nextPage = firstChoice.page
            let pageController = PageController(page: nextPage)
            
            /*Every view controller has an optional property, navigation controller.
             If your view controller is part of a navigation stack,
             this property refers to the navigation controller that we're embedded in.
             Using this property we can ask the navigation controller
             to push another view controller onto the stack.
             This is IDENTICAL behavior to the SEGUE that we created in the storyboard scene.
             Except here we're calling it explicitly and
             passing in the view controller as a parameter or as an argument.*/
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    // Why doesn't this method need @objc ? Oh, prob. cause I haven't connected it to a button yet.
    @objc func loadSecondChoice() {
        if let page = page, let secondChoice = page.secondChoice {
            let nextPage = secondChoice.page
            let pageController = PageController(page: nextPage)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    @objc func playAgain(){
        navigationController?.popToRootViewController(animated: true)
    }
}










