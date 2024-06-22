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
    
    enum CodingKeys: CodingKey {
        case id, name, content, bookmarks, imageUrl
    }
    
    init(id: String? = nil, name: String, content: String, bookmarks: Int, imageUrl: String) {
        self.id = id
        self.name = name
        self.content = content
        self.bookmarks = bookmarks
        self.imageUrl = imageUrl
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.content = try container.decode(String.self, forKey: .content)
        self.bookmarks = try container.decode(Int.self, forKey: .bookmarks)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        
        
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(content, forKey: .content)
        try container.encode(bookmarks, forKey: .bookmarks)
        try container.encode(imageUrl, forKey: .imageUrl)
        
    }
    public static func ==(lhs: Hackathon, rhs: Hackathon) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
