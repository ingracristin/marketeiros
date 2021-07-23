//
//  StringExtension.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import Foundation

extension String {
    func removeCharactersContained(in characters : String) -> String {
        let newString = self.filter {!characters.contains($0)}
        return newString
    }
}
