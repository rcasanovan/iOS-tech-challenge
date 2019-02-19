//
//  EndPoint.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    var url: URL? { get }
}

/**
 * Internal struct for Url
 */
private struct Url {
    
    static let baseUrl: String = "https://itunes.apple.com/search"
    
    struct Fields {
        static let term: String = "term"
    }
    
}

// MARK: - Endpoints
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .getArtistWith(let search):
            var endpoint = "?media=musicVideo&entity=musicVideo&attribute=artistTerm&limit=200"
            
            if let search = search, let searchWithUrlFormat = search.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                endpoint = "\(endpoint)&\(Url.Fields.term)=\(searchWithUrlFormat)"
            }
            
            return endpoint
        }
    }
    
    case getArtistWith(search: String?)
    
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: Url.baseUrl + self.rawValue)
        return urlComponents?.url
    }
    
}