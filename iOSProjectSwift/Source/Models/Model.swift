//
//  Model.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

enum ModelState {
    case isCreated
    case didUnload
    case willLoad
    case didLoad
    case didFailLoading
    case didChange
}

//class Model: ObservableObject {
//    
//    //MARK: - Public Functions
//    
//    func load() {
//        synchronized(self) {
//            let state = self.state
//            if state == .willLoad || state == .didLoad {
//                self.notifyOfState()
//                return
//            }
//            self.state = .willLoad
//        }
//        
//        self.processLoading()
//    }
//    
//    //method created for overriding, do not call directly
//    func performLoadingInBackground() {
//        
//    }
//    
//    //MARK: - Private Functions
//    
//    private func processLoading() {
//        DispatchQueue.global(qos: .background).async {
//            self.performLoadingInBackground()
//        }
//    }
//}
