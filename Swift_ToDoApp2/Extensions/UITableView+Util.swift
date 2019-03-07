//
//  UITableView+Util.swift
//  Swift_ToDoApp2
//
//  Created by 一木 英希 on 2019/03/02.
//  Copyright © 2019 一木 英希. All rights reserved.
//

import UIKit

extension UITableView {
    
    // func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(withClass type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass type: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type)) as! T
    }
}
