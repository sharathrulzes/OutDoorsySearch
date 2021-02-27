//
//  Outdoorsy.swift
//  OutdoorsySearch
//
//  Created by Sharat on 2/26/21.
//

import Foundation
import UIKit
struct OutdoorsyResponse: Decodable {
    var data: [Outdoorsy]?
    var included: [InculdedData]?
    enum CodingKeys: String, CodingKey {
        case data
        case included
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode([Outdoorsy].self, forKey: .data)
        included = try? container.decode([InculdedData].self, forKey: .included)
    }
    
    func getImageUrlOftheRental(_ input: String?) -> String {
        let obj = self.included?.filter {$0.id == input && $0.type == "images"}.first
        guard let e = obj, let url = e.attributes?.url  else {
            return ""
        }
        return url
    }
}

struct Outdoorsy: Decodable {
    var id: String?
    var attributes: Attributes?
    var relationships: Relationships?
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
        case relationships
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(String.self, forKey: .id)
        attributes = try? container.decode(Attributes.self, forKey: .attributes)
        relationships = try? container.decode(Relationships.self, forKey: .relationships)
    }
    
   
}
struct Relationships: Decodable {
    var primaryImage: PrimaryImage?
    enum CodingKeys: String, CodingKey {
        case primary_image
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        primaryImage = try? container.decode(PrimaryImage.self, forKey: .primary_image)
    }
}

struct PrimaryImage: Decodable {
    var data: DataObj?
    enum CodingKeys: String, CodingKey {
        case data
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decode(DataObj.self, forKey: .data)
    }
}

struct DataObj: Decodable {
    var id: String?
    var type: String?
    enum CodingKeys: String, CodingKey {
        case id
        case type

    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(String.self, forKey: .id)
        type = try? container.decode(String.self, forKey: .type)

    }
    
}

struct Attributes: Decodable {
    var name: String?
    enum CodingKeys: String, CodingKey {
        case name
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
    }
}

struct InculdedData: Decodable {
    var id: String?
    var type: String?
    var attributes: InculdedAttribute?
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case attributes
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(String.self, forKey: .id)
        type = try? container.decode(String.self, forKey: .type)
        attributes = try? container.decode(InculdedAttribute.self, forKey: .attributes)
    }
    
}

struct InculdedAttribute: Decodable {
    var url: String?
    enum CodingKeys: String, CodingKey {
        case url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try? container.decode(String.self, forKey: .url)
    }
}




