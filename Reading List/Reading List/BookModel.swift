import Foundation

struct Book: Equatable, Comparable, Codable
{
	var name:String
	var readingReason:String
	var read:Bool

	static func ==(lhs:Book, rhs:Book) -> Bool
	{
		return lhs.name == rhs.name && lhs.readingReason == rhs.readingReason
	}
	static func <(lhs:Book, rhs:Book) -> Bool
	{
		if lhs.read || rhs.read {
			if lhs.read && rhs.read {
				return lhs.name < rhs.name
			}

			return lhs.read
		}

		return lhs.name < rhs.name
	}
}
