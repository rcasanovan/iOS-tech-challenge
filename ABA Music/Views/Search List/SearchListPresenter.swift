//
//  SearchListPresenter.swift
//  ABA Music
//
//  Created by Ricardo Casanova on 19/02/2019.
//  Copyright © 2019 ABA English. All rights reserved.
//

import Foundation

class SearchListPresenter {
    
    private weak var view: SearchListViewInjection?
    private let interactor: SearchListInteractorDelegate
    private let router: SearchListRouterDelegate
    
    // MARK - Lifecycle
    init(view: SearchListViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = SearchListInteractor()
        self.router = SearchListRouter(navigationController: navigationController)
    }
    
}

// MARK: - Private section
extension SearchListPresenter {
    
    /**
     * Get tracks
     *
     * - parameters:
     *      -search: the search term
     *      -showProgress: a boolean to show / hide the progress
     */
    private func getTracks(_ search: String? = nil, showProgress: Bool) {
        view?.showProgress(showProgress, status: "Loading tracks")
        
        interactor.getTracksList(search: search) { [weak self] (artists, success, error) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let artists = artists {
                self.view?.loadTracks(artists, fromBeginning: showProgress)
                return
            }
            
            if let error = error {
                self.view?.showMessageWith(title: "Oops... 🧐", message: error.localizedDescription, actionTitle: "Accept")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Oops... 🧐", message: "Something wrong happened. Please try again", actionTitle: "Accept")
                return
            }
        }
    }
    
}

// MARK: - SearchListPresenterDelegate
extension SearchListPresenter: SearchListPresenterDelegate {
    
    /**
     * View did load
     */
    func viewDidLoad() {
        interactor.clear()
        let initialSearch = interactor.getInitialSearch()
        getTracks(initialSearch, showProgress: true)
    }
    
    /**
     * Search track
     *
     * - parameters:
     *      -search: the search term
     */
    func searchTrack(_ search: String?) {
        interactor.clear()
        getTracks(search, showProgress: true)
    }
    
    /**
     * Track selected at section / index
     */
    func trackSelectedAt(section: Int, index: Int) {
        guard let trackSelected = interactor.getTrackSelectedAt(section: section, index: index) else {
            return
        }
        
        router.showTrackDetail(trackSelected)
    }
    
    /**
     * Get all suggestions
     */
    func getSuggestions() {
        interactor.getAllSuggestions { [weak self] (suggestions) in
            guard let `self` = self else { return }
            self.view?.loadSuggestions(suggestions)
        }
    }
    
    /**
     * Suggestion selected at index
     *
     * - parameters:
     *      -index: selected index
     */
    func suggestionSelectedAt(_ index: Int) {
        guard let suggestion = interactor.getSuggestionAt(index: index) else {
            return
        }
        searchTrack(suggestion.suggestion)
    }
    
}
