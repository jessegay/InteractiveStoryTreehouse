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
    
    // MARK: - User Interface Properties
    
    let artworkView = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceButton = UIButton(type: .system)
    let secondChoiceButton = UIButton(type: .system)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let page = page {
            artworkView.image = page.story.artwork
            // Let's style the text. Need to create NSMutableAttributedString then modify its properties.
            let attributedString = NSMutableAttributedString(string: page.story.text)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            storyLabel.attributedText = attributedString // Changed from storyLabel.text to .attributedText in order to accept  attributedString (which is instance of NSMutableAttributedString)
            
            if let firstChoice = page.firstChoice {
                firstChoiceButton.setTitle(firstChoice.title, for: .normal)
            } else {
                firstChoiceButton.setTitle("Play Again", for: .normal)
            }
            
            if let secondChoice = page.secondChoice {
                secondChoiceButton.setTitle(secondChoice.title, for: .normal)
            } 
            
        }
        // Do any additional setup after loading the view.
    }
    
    // When ViewController's view is initialized, it checks to see if it has any subviews. It includes the viewWillLayoutSubviews method (or was it viewDidLayoutSubviews?), which, by default, does nothing, but we can override it to add subviews, that the View will create as it cycles through it's subview setup.
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews() // notice we call the superclass first, and we've already called super.viewDidLoad()
        view.addSubview(artworkView) // This is how we add a subview.
        artworkView.translatesAutoresizingMaskIntoConstraints = false // This overrides autolayouts inferred constraints.
        
        //  artworkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true // this sets the topAnchor of the artworkView subView to the topAnchor of the View, and makes it active. We could do this for every parameter, but it would get tedious. It's more efficient to use NSLayoutContraint.activate, and pass in an array of constraints. This is how we activate and constrain the subview we just added.
        NSLayoutConstraint.activate([
            artworkView.topAnchor.constraint(equalTo: view.topAnchor),
            artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
            artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])
        
        view.addSubview(storyLabel)
        storyLabel.numberOfLines = 0
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
            ])
        
        view.addSubview(firstChoiceButton)
        firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
            ])
       
        view.addSubview(secondChoiceButton)
        secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
            ])
    }
}










