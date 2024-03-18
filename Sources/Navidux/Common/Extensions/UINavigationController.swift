//
//  UINavigationController.swift
//
//
//  Created by Tamerlan Satualdypov on 06.03.2024.
//

import UIKit

extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    @discardableResult
    func popViewController(animated: Bool, completion: (() -> Void)?) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        let vc = self.popViewController(animated: animated)
        
        CATransaction.commit()
        
        return vc
    }
    
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        let vcs = self.popToViewController(viewController, animated: animated)
        
        CATransaction.commit()
        
        return vcs
    }
}
