//
//  MainContentsKind.swift
//  Swift_ToDoApp2
//
//  Created by 一木 英希 on 2019/02/26.
//  Copyright © 2019 一木 英希. All rights reserved.
//

import UIKit

enum ContentsKind {
    case toDo
    
    var description: String {
        switch self {
        case .toDo: return "ToDoList"
        }
    }
    
}
