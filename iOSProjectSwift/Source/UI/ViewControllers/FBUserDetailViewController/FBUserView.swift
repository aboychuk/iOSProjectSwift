//
//  FBDetailView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/30/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUserView: BaseView {
    
    // MARK: - Properties
    
    @IBOutlet var friendsButton: UIButton?
    @IBOutlet var imageView: ImageView?
    @IBOutlet var userFullName: UILabel?
    @IBOutlet var logoutBarButton: UIBarButtonItem?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.logoutBarButton = createBarButton(title: "Logout")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.logoutBarButton = createBarButton(title: "Logout")
    }
    
    // MARK: - Public
    
    func fillWithModel(_ model: UserType) {
        self.userFullName?.text = model.fullName
        self.imageView?.urlString = model.imageUrl
    }
    
    // MARK: - Private
    // TODO: - Move to category
    private func createBarButton(title: String) -> UIBarButtonItem {
        let button = UIBarButtonItem.init()
        button.title = title
        button.style = .done
        
        return button
    }
}
