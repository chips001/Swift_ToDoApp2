//
//  ContainerViewController.swift
//  Swift_ToDoApp2
//
//  Created by 一木 英希 on 2019/02/26.
//  Copyright © 2019 一木 英希. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var didTapBarButtonHandler: (() -> Void)?
    
    private var controllerList:[TopLevelMenuKind] = [
        .main(.toDo)
    ]
    
    private var currentNavigationController: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFirstViewController()
    }
    
    private func setupFirstViewController() {
        let firstViewController = self.instantiateToViewController(kind: self.controllerList[0])
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        self.currentNavigationController = firstNavigationController
        
        self.addChild(firstNavigationController)
        self.view.insertSubview(firstNavigationController.view, at: 0)
        firstNavigationController.didMove(toParent: self)
    }
    
    private func instantiateToViewController(kind: TopLevelMenuKind) -> UIViewController {
        let toViewController: UIViewController
        switch kind {
        case .main(let kind):
            let viewController = MainListViewController.instantiateFromStoryboard()
            viewController.contentsKind = kind
            toViewController = viewController
        }
        return toViewController
    }
        
    func showChildViewController(kind: TopLevelMenuKind) {
        
        guard let fromNavigationController = self.currentNavigationController else { return }
        let toViewController = self.instantiateToViewController(kind: kind)
        let toNavigationController = UINavigationController(rootViewController: toViewController)
        
        fromNavigationController.willMove(toParent: nil)
        self.addChild(toNavigationController)
        self.transition(
            from: fromNavigationController,
            to: toNavigationController,
            duration: 0,
            options: [],
            animations: nil,
            completion: { [weak self] _ in
                guard let `self` = self else { return }
                
                fromNavigationController.removeFromParent()
                toNavigationController.didMove(toParent: self)
                self.currentNavigationController = toNavigationController
        })
    }
}
