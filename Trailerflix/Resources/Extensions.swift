//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Daniel Vassalo on 16/11/22.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
