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
        let list = userDefaults.object(forKey: "favouriteList") as? [Int]
        guard var list = list else {
            userDefaults.set([id], forKey: "favouriteList")
            return
        }
        list.append(id)
        userDefaults.set(list, forKey: "favouriteList")
        userDefaults.synchronize()
    }
    
    func deleteFavourite(id: Int) {
        let userDefaults = UserDefaults.standard
        let list = userDefaults.object(forKey: "favouriteList") as? [Int]
        guard var list = list else {
            return
        }
        list.removeFirst(id)
        userDefaults.set(list, forKey: "favouriteList")
        userDefaults.synchronize()
    }

    func isFavourite(id: Int) -> Bool {
        let userDefaults = UserDefaults.standard
        let list = userDefaults.object(forKey: "favouriteList") as? [Int]
        guard let list = list else {
            return false
        }
        return list.contains(id)

    }
    
    func getFavourite() -> [Int] {
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "favouriteList") as? [Int] ?? []
    }

}
