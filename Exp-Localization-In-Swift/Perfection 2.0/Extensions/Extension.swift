//
//  Extension.swift
//  Perfection 2.0
//
//  Created by Sidney Okine on 23/09/2022.
//

import Foundation

extension String {
    func localised() -> String{
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
