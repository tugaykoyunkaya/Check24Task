//
//  UserDefaults + Extension.swift
//  Check24Task
//
//  Created by Tugay Koyunkaya on 7.01.2022.
//

import Foundation

extension UserDefaults {
    
    func addFavourite(id: Int) {
        let userDefaults = UserDefaults.standard
        var list = getFavourite()
        list.append(id)
        userDefaults.set(list, forKey: "favouriteList")
        userDefaults.synchronize()
    }
    
    func deleteFavourite(id: Int) {
        let userDefaults = UserDefaults.standard
        var list = getFavourite()
        list = list.filter { $0 != id }
        userDefaults.set(list, forKey: "favouriteList")
        userDefaults.synchronize()
    }

    func isFavourite(id: Int) -> Bool {
        let list = getFavourite()
        return list.contains(id)
    }
    
    private func getFavourite() -> [Int] {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "favouriteList") as? [Int] ?? []
    }
}
