//
//  Model.swift
//  BookmarkApp
//
//  Created by Nursat Sakyshev on 06.05.2023.
//

import Foundation

struct Bookmark: Codable {
    var name: String
    var link: String
}

var bookmarks: [Bookmark] {
    set {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: "bookmarks")
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }

    get {
        let defaultValue: [Bookmark] = []
        guard let data = try? UserDefaults.standard.object(forKey: "bookmarks") as? Data else {
            return defaultValue
        }
        let value = try? JSONDecoder().decode([Bookmark].self, from: data)
        return value ?? defaultValue
    }
}

func addBookmark(name: String, link: String) {
    bookmarks.append(Bookmark(name: name, link: link))
}

func removeBookmark(at Index: Int) {
    bookmarks.remove(at: Index)
}

