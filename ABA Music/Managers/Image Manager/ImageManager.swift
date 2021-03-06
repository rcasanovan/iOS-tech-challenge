//
//  ImageManager.swift
//  ABA Music
//
//  Created by Ricardo Casanova on 20/02/2019.
//  Copyright © 2019 ABA English. All rights reserved.
//

import Foundation

enum ImageType {
    case small
    case medium
    case large
}

class ImageManager {
    
    static let shared: ImageManager = { return ImageManager() }()
    
    /**
     * Internal struct for url
     */
    private struct Url {
        
        struct ImageSize {
            static let small: String = "30x30"
            static let medium: String = "60x60"
            static let large: String = "100x100"
            static let extraLarge: String = "200x200"
        }
        
    }
    
    public func getExtraLargeUrlWith(_ originalUrl: URL?, type: ImageType) -> URL? {
        guard let originalUrl = originalUrl else {
            return nil
        }
        
        var urlString = originalUrl.absoluteString
        switch type {
        case .small:
            urlString = urlString.replacingFirstOccurrence(of: Url.ImageSize.small, with: Url.ImageSize.extraLarge)
        case .medium:
            urlString = urlString.replacingFirstOccurrence(of: Url.ImageSize.medium, with: Url.ImageSize.extraLarge)
        case .large:
            urlString = urlString.replacingFirstOccurrence(of: Url.ImageSize.large, with: Url.ImageSize.extraLarge)
        }
        
        return URL(string: urlString)
    }
    
}
