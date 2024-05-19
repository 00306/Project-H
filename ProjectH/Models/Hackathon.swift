//
//  Hackathon.swift
//  ProjectH
//
//  Created by 송지혁 on 5/15/24.
//

import FirebaseFirestore
import Observation

struct Hackathon: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let name: String
    let description: String
    var bookmarks: Int
    let imageUrl: String
}
