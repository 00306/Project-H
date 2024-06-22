//
//  Hackathon.swift
//  ProjectH
//
//  Created by 송지혁 on 5/15/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftData

@Model
class Hackathon: Identifiable, Codable, Hashable {
    var id: String?
    let name: String
    let content: String
    var bookmarks: Int
    let imageUrl: String
}
    init(id: String? = nil, name: String, content: String, bookmarks: Int, imageUrl: String) {
        self.id = id
        self.name = name
        self.content = content
        self.bookmarks = bookmarks
        self.imageUrl = imageUrl
    }
