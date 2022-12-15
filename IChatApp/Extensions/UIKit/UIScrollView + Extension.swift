//
//  UIScrollView + Extension.swift
//  IChatApp
//
//  Created by Владислав Моисеев on 14.12.2022.
//

import UIKit

extension UIScrollView {
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInsert = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInsert - scrollViewHeight
        return scrollViewBottomOffset
    }
    
}
