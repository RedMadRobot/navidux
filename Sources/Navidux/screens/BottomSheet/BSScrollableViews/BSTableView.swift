// https://habr.com/ru/companies/koshelek/articles/703260/

import UIKit

open class BSTableView: UITableView {
    
    // При получении самого актуального значения высоты contentSize, запускаем обновление константы
    open override var contentSize: CGSize {
        didSet {
            fixHeight()
        }
    }
  
    // Создаем констрейнт с минимальным приоритетом, чтобы в случае, если высота контента будет больше,
    // чем может быть высота bottom sheet, не случился конфликт приоритетов.
    open lazy var collectionHeightConstraint: NSLayoutConstraint = {
        let constraint = heightAnchor.constraint(equalToConstant: 0)
        constraint.priority = .defaultLow
        constraint.isActive = true
        return constraint
    }()
    
    // Также, кроме высоты, учитываем и все дополнительные отступы и инсеты.
    open func fixHeight() {
        var height = contentSize.height
        height += contentInset.top
        height += contentInset.bottom
        height += safeAreaInsets.bottom
        height += (tableHeaderView?.frame.height ?? 0)
        height += (tableFooterView?.frame.height ?? 0)
        
        // Значение высоты равное 0 нет смысла обновлять, а равное infinity — ломает констрейнты, а вместе с ними и autoLayout
        if height != 0 && height != .infinity {
            collectionHeightConstraint.constant = height
        }
    }
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer === panGestureRecognizer else {
            return true
        }
      
        if contentOffset.y == -contentInset.top, panGestureRecognizer.velocity(in: nil).y > 0 {
            return false
        }

        if contentOffset.y < -contentInset.top {
            return false
        }

        return true
    }
}


