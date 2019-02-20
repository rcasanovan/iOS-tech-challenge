//
//  TrackCollectionViewCell.swift
//  ABA Music
//
//  Created by Ricardo Casanova on 20/02/2019.
//  Copyright © 2019 ABA English. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    
    private let trackImageView: UIImageView = UIImageView()
    
    /**
     * Identifier for reusable cells
     */
    static public var identifier : String {
        return String(describing: self)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

// MARK:- Layout & Constraints
extension TrackCollectionViewCell {
    
    /**
     * Private struct for internal layout
     */
    private struct Layout {
        
    }
    
    /**
     * Common init method to setup all the components
     */
    private func setupViews() {
        configureSubviews()
        addSubviews()
    }
    
    /**
     * Configure the elements inside the component
     */
    private func configureSubviews() {
        backgroundColor = .clear
        
        trackImageView.backgroundColor = .yellow
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(trackImageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: trackImageView)
        addConstraintsWithFormat("V:|[v0(100.0)]", views: trackImageView)
    }
    
}
