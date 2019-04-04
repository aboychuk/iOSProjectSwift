//
//  FBUserCell.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 08.12.2017.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUserCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet var userImageView: ImageView?
    @IBOutlet var fullNameLabel: UILabel?
    
    var userModel: FBUser? {
        willSet {
            if let model = newValue {
                self.fillWithModel(model)
            }
        }
    }
    
    //MARK - Public functions
    
    func fillWithModel(_ model: FBUser) {
        self.fullNameLabel?.text = model.fullname
        self.userImageView?.url = model.imageURL
    }
    
    //MARK - Overriden functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userImageView?.contentImageView?.image = nil
    }
}

