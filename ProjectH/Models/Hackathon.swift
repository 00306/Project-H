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
    let name: String
    let description: String
    var bookmarks: Int
    let imageUrl: String
}
