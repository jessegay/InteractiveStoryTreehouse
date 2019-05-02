//
//  Page.swift
//  InteractiveStoryTreehouseCourse
//
//  Created by Jesse Gay on 5/1/19.
//  Copyright © 2019 Jesse Gay. All rights reserved.
//

import Foundation

class Page {
    let story: Story
    
    // typealias allows for a more readable use of the values. This is just a tuple, but calling it Choice makes it read better.
    typealias Choice = (title: String, page: Page)
    
    var firstChoice: Choice?
    var secondChoice: Choice?
    
    init(story: Story) {
        self.story = story
    }
}

extension Page {
    
    
    func addChoiceWith(title: String, page: Page) -> Page {
        
        switch (firstChoice, secondChoice) {
        case(.some, .some): return self
        case(.none, .none), (.none, .some): firstChoice = (title, page)
        case (.some, .none): secondChoice = (title, page)
        }
        return page
    }
}
