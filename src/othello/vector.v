module othello

struct Vector {
	x int
	y int
}

pub fn vector_add(vector Vector, addVector Vector) Vector {
	return Vector{vector.x + addVector.x, vector.y + addVector.y}
}

pub fn get_directionnal_vectors() []Vector {
	return [
		Vector{ x: 0, y: 1 },
		Vector{ x: 1, y: 1 },
		Vector{ x: 1, y: 0 },
		Vector{ x: 1, y: -1 },
		Vector{ x: 0, y: -1 },
		Vector{ x: -1, y: -1 },
		Vector{ x: -1, y: 0 },
		Vector{ x: -1, y: 1 }
	]
}