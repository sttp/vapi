module data

struct OrderByTerm {
mut:
	column      &DataColumn
	ascending   bool
	exact_match bool
}
