//
//  MyOrderedSet.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

public protocol MyType: Hashable, Codable {
	
}

public struct MyOrderedSet<Type: MyType> {
	var sequencedContents: [Type]
	var contents: [Type: Int]
//	private var sequencedContents = [Type]()
//	private var contents = [Type: Int]()

	init() {
		sequencedContents = []
		contents = [:]
	}
	
	func index(of object: Type) -> Int? {
		if let index = contents[object] {
			return index
		}
		return nil
	}
	
	mutating func append(_ object: Type) {
		if contents[object] == nil {
			contents[object] = contents.count
			sequencedContents.append(object)
		}
	}
	
	mutating func remove(_ object: Type) {
		guard let index = contents[object] else { return }
		remove(at: index)
	}
	
	mutating func remove(at index: Int) {
//		guard sequencedContents.count > index else { return } // dno if this is a good idea or not
		let objectAtIndex = sequencedContents[index]
		contents.removeValue(forKey: objectAtIndex)
		sequencedContents.remove(at: index)
		for index in index..<sequencedContents.count {
			contents[sequencedContents[index]] = index
		}
	}
	
	func contains(_ element: Type) -> Bool {
		return contents[element] != nil
	}
	
	public subscript(index: Int) -> Type {
		get {
			return sequencedContents[index]
		}
		set {
			if contents[newValue] != nil {
				//remove existing value (coalesce to the rest of the stuff)
				remove(newValue)
			}
			if sequencedContents[index] != newValue {
				contents.removeValue(forKey: sequencedContents[index])
			}
			sequencedContents[index] = newValue
			contents[newValue] = index
		}
	}
	
	public var count: Int {
		return sequencedContents.count
	}
	
	public var isEmpty: Bool {
		return sequencedContents.isEmpty
	}
	
	
	
	enum CodingKeys: String, CodingKey {
		case sequencedContents
		case contents
	}
}

extension MyOrderedSet: RandomAccessCollection {
	public var startIndex: Int {
		return 0
	}
	
	public var endIndex: Int {
		return sequencedContents.count
	}
}

extension MyOrderedSet: Codable {

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(sequencedContents, forKey: CodingKeys.sequencedContents)
//		try container.encode(contents, forKey: CodingKeys.sequencedContents)

	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		sequencedContents = try container.decode([Type].self, forKey: .sequencedContents)
//		contents = try container.decode([Type: Int].self, forKey: CodingKeys.contents)
		contents = [:]
		for (index, element) in sequencedContents.enumerated() {
			contents[element] = index
		}
	}
}
