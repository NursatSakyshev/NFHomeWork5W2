//
//  Model.swift
//  BookmarkApp
//
//  Created by Nursat Sakyshev on 06.05.2023.
//

import Foundation

var bookmarks: [[String: String]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "bookmarks")
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "bookmarks") as? [[String: String]] {
            return array
        }
        else {
            return []
        }
    }
}

func addBookmark(name: String, link: String) {
    bookmarks.append(["name": name, "link": link])
}

func removeBookmark(at Index: Int) {
    bookmarks.remove(at: Index)
}

