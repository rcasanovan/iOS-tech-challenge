//
//  SuggestionsTests.swift
//  ABA MusicTests
//
//  Created by Ricardo Casanova on 19/02/2019.
//  Copyright © 2019 ABA English. All rights reserved.
//

import XCTest
@testable import ABA_Music

class SuggestionsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDeleteAllSuggestions() {
        SearchSuggestionsManager.shared.saveSuggestion("The beatles")
        SearchSuggestionsManager.shared.saveSuggestion("Oasis")
        SearchSuggestionsManager.shared.saveSuggestion("Rolling Stones")
        SearchSuggestionsManager.shared.saveSuggestion("Blur")
        SearchSuggestionsManager.shared.saveSuggestion("The verve")
        SearchSuggestionsManager.shared.deleteAllSuggestions()
        
        let suggestions = SearchSuggestionsManager.shared.getSuggestions()
        XCTAssert(suggestions.count == 0)
    }
    
    func testSaveSuggestions() {
        SearchSuggestionsManager.shared.deleteAllSuggestions()
        
        SearchSuggestionsManager.shared.saveSuggestion("The beatles")
        SearchSuggestionsManager.shared.saveSuggestion("Oasis")
        SearchSuggestionsManager.shared.saveSuggestion("Rolling Stones")
        SearchSuggestionsManager.shared.saveSuggestion("Blur")
        SearchSuggestionsManager.shared.saveSuggestion("The verve")
        
        let suggestions = SearchSuggestionsManager.shared.getSuggestions()
        XCTAssert(suggestions.count == 5)
    }
    
    func testOrderSuggestions() {
        SearchSuggestionsManager.shared.deleteAllSuggestions()
        
        SearchSuggestionsManager.shared.saveSuggestion("The beatles")
        SearchSuggestionsManager.shared.saveSuggestion("Oasis")
        SearchSuggestionsManager.shared.saveSuggestion("Rolling Stones")
        
        let suggestions = SearchSuggestionsManager.shared.getSuggestions()
        XCTAssert(suggestions[0].suggestion == "rolling stones" &&
            suggestions[1].suggestion == "oasis" &&
            suggestions[2].suggestion == "the beatles")
    }
    
    func testOnlyMaintainFirstSuggestions() {
        SearchSuggestionsManager.shared.deleteAllSuggestions()
        
        SearchSuggestionsManager.shared.saveSuggestion("The beatles")
        SearchSuggestionsManager.shared.saveSuggestion("Oasis")
        SearchSuggestionsManager.shared.saveSuggestion("Rolling Stones")
        SearchSuggestionsManager.shared.saveSuggestion("Blur")
        SearchSuggestionsManager.shared.saveSuggestion("The verve")
        SearchSuggestionsManager.shared.saveSuggestion("Alex Turner")
        SearchSuggestionsManager.shared.saveSuggestion("Alabama Shakes")
        SearchSuggestionsManager.shared.saveSuggestion("Beady Eye")
        SearchSuggestionsManager.shared.saveSuggestion("Liam Gallagher")
        SearchSuggestionsManager.shared.saveSuggestion("Noel Gallagher")
        
        SearchSuggestionsManager.shared.saveSuggestion("Liam Gallagher")
        
        let suggestions = SearchSuggestionsManager.shared.getSuggestions()
        XCTAssert(suggestions.count == 10, "Max number of suggestions should be 10")
    }
    
    func testMovieExists() {
        SearchSuggestionsManager.shared.deleteAllSuggestions()
        
        SearchSuggestionsManager.shared.saveSuggestion("Alex Turner")
        SearchSuggestionsManager.shared.saveSuggestion("Alabama Shakes")
        SearchSuggestionsManager.shared.saveSuggestion("Beady Eye")
        SearchSuggestionsManager.shared.saveSuggestion("Liam Gallagher")
        SearchSuggestionsManager.shared.saveSuggestion("Noel Gallagher")
        
        let suggestionExists = SearchSuggestionsManager.shared.suggestionExists("Noel Gallagher")
        XCTAssert(suggestionExists == true, "The suggestion doesn't exist in the data base")
    }

}