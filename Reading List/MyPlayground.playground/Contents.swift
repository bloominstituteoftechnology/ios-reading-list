import UIKit

let list:[Bool ] = [true, false, true, false, true]

let truelist = list.filter({
	$0 == true
})
print(truelist)
