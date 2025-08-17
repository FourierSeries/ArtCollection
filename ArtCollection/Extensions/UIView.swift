//
//  UIView.swift
//  ArtCollection
//
//  Created by Alekseeva Olga on 16.08.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
