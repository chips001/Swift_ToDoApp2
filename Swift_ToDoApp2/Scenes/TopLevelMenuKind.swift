//
//  TopLevelMenuKind.swift
//  Swift_ToDoApp2
//
//  Created by 一木 英希 on 2019/02/26.
//  Copyright © 2019 一木 英希. All rights reserved.
//

import UIKit

enum TopLevelMenuKind: Equatable {
    case main(ContentsKind)
    
    var controllerType: UIViewController.Type {
        switch self {
        case .main: return MainListViewController.self
        }
    }
    
    var title: String {
        switch self {
        case .main: return "MainList"
        }
    }
    
}
