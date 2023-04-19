module hashset
const member=Void{}
type HashSet = map[T]void
struct Void {}
// NewHashSet creates a new set containing all elements in the specified sl
pub fn new_hash_set(items []T) (HashSet, ) {mut hs:=HashSet[t ] {len: items .len }  
hs.union_with(items ,)
return hs 
}

// Add adds the specified element to a 
pub fn (mut hs HashSet) add<T>(item T) (bool, ) {if hs.contains(item ,) {
return false 
}
hs[item ]=member  
return true 
}

// Remove removes the specified element from a 
pub fn (mut hs HashSet) remove<T>(item_1 T) (bool, ) {if hs.contains(item_1 ,) {
hs .delete(item_1 ,)
return true 
}
return false 
}

// RemoveWhere removes all elements that match the conditions defined by the specified predicate from a 
pub fn (mut hs HashSet) remove_where(predicate fn <T>( T) (bool, ) ) (int, ) {mut removed_count:=0 
for k, _ in  hs  {
if predicate(k ,)  &&  hs.remove(k ,)  {
removed_count++
}
}
return removed_count 
}

// IsEmpty determines if set contains no eleme
pub fn (mut hs HashSet) is_empty() (bool, ) {return hs .len  ==  0  
}

// Clear removes all elements from a 
pub fn (mut hs HashSet) clear() {for k, _ in  hs  {
hs .delete(k ,)
}
}

// Contains determines whether a set contains the specified elem
pub fn (mut hs HashSet) contains<T>(item_2 T) (bool, ) {mut _,ok:=hs[item_2 ]  
return ok 
}

// Keys copies the elements of a set to a sl
pub fn (mut hs HashSet) keys() ([]T, ) {mut keys_1:=[]T{len: hs .len }  
mut i:=0  
for k, _ in  hs  {
keys_1[i ]=k  
i++
}
return keys_1 
}

// ExceptWith removes all elements in the specified slice from the current 
pub fn (mut hs HashSet) except_with(other []T) {for _, v in  other  {
hs .delete(v ,)
}
}

// ExceptWithSet removes all elements in the specified set from the current 
pub fn (mut hs HashSet) except_with_set(other_1 HashSet) {hs.except_with(other_1.keys() ,)
}

// SymmetricExceptWith modifies the current set to contain only elements that are present either in the set or in the specified slice, but not b
pub fn (mut hs HashSet) symmetric_except_with(other_2 []T) {if hs.is_empty() {
hs.union_with(other_2 ,)
return 
}
for _, v in  other_2  {
if ! hs.remove(v ,)  {
hs.add(v ,)
}
}
}

// SymmetricExceptWithSet modifies the current set to contain only elements that are present either in the set or in the specified set, but not b
pub fn (mut hs HashSet) symmetric_except_with_set(other_3 HashSet) {hs.symmetric_except_with(other_3.keys() ,)
}

// IntersectWith modifies the current set to contain only elements that are present in the set and in the specified sl
pub fn (mut hs HashSet) intersect_with(other_4 []T) {hs.intersect_with_set(new_hash_set(other_4 ,) ,)
}

// IntersectWithSet modifies the current set to contain only elements that are present in the set and in the specified 
pub fn (mut hs HashSet) intersect_with_set(other_5 HashSet) {if hs .len  ==  0  {
return 
}
if other_5 .len  ==  0  {
hs.clear()
return 
}
for k, _ in  hs  {
if ! other_5.contains(k ,)  {
hs.remove(k ,)
}
}
}

// UnionWith modifies the current set to contain all elements that are present in the set, the specified slice, or b
pub fn (mut hs HashSet) union_with(other_6 []T) {for _, v in  other_6  {
hs.add(v ,)
}
}

// UnionWithSet modifies the current set to contain all elements that are present in the set, the specified set, or b
pub fn (mut hs HashSet) union_with_set(other_7 HashSet) {hs.union_with(other_7.keys() ,)
}

// SetEquals determines whether a set and the specified slice contain the same eleme
pub fn (mut hs HashSet) set_equals(other_8 []T) (bool, ) {if hs .len  !=  other_8 .len  {
return false 
}
for _, v in  other_8  {
if ! hs.contains(v ,)  {
return false 
}
}
return true 
}

// SetEqualsSet determines whether a set and the specified set contain the same eleme
pub fn (mut hs HashSet) set_equals_set(other_9 HashSet) (bool, ) {return hs.set_equals(other_9.keys() ,) 
}

// Overlaps determines whether the current set and a specified slice share common eleme
pub fn (mut hs HashSet) overlaps(other_10 []T) (bool, ) {if hs.is_empty() {
return false 
}
for _, v in  other_10  {
if hs.contains(v ,) {
return true 
}
}
return false 
}

// OverlapsSet determines whether the current set and a specified set share common eleme
pub fn (mut hs HashSet) overlaps_set(other_11 HashSet) (bool, ) {return hs.overlaps(other_11.keys() ,) 
}

// IsSubsetOf determines whether a set is a subset of the specified sl
pub fn (mut hs HashSet) is_subset_of(other_12 []T) (bool, ) {return hs.is_subset_of_set(new_hash_set(other_12 ,) ,) 
}

// IsSubsetOfSet determines whether a set is a subset of the specified 
pub fn (mut hs HashSet) is_subset_of_set(other_13 HashSet) (bool, ) {if hs.is_empty() {
return true 
}
if hs .len  >  other_13 .len  {
return false 
}
for k, _ in  hs  {
if ! other_13.contains(k ,)  {
return false 
}
}
return true 
}

// IsProperSubsetOf determines whether a set is a proper subset of the specified sl
pub fn (mut hs HashSet) is_proper_subset_of(other_14 []T) (bool, ) {return hs.is_proper_subset_of_set(new_hash_set(other_14 ,) ,) 
}

// IsProperSubsetOfSet determines whether a set is a proper subset of the specified 
pub fn (mut hs HashSet) is_proper_subset_of_set(other_15 HashSet) (bool, ) {if hs.is_empty() {
return other_15 .len  >  0  
}
if hs .len  >=  other_15 .len  {
return false 
}
for k, _ in  hs  {
if ! other_15.contains(k ,)  {
return false 
}
}
return true 
}

// IsSupersetOf determines whether a set is a superset of the specified sl
pub fn (mut hs HashSet) is_superset_of(other_16 []T) (bool, ) {if other_16 .len  ==  0  {
return true 
}
if other_16 .len  >  hs .len  {
return false 
}
for _, v in  other_16  {
if ! hs.contains(v ,)  {
return false 
}
}
return true 
}

// IsSupersetOfSet determines whether a set is a superset of the specified 
pub fn (mut hs HashSet) is_superset_of_set(other_17 HashSet) (bool, ) {return hs.is_superset_of(other_17.keys() ,) 
}

// IsProperSupersetOf determines whether a set is a proper superset of the specified sl
pub fn (mut hs HashSet) is_proper_superset_of(other_18 []T) (bool, ) {if hs.is_empty() {
return true 
}
if other_18 .len  ==  0  {
return true 
}
if other_18 .len  >=  hs .len  {
return false 
}
for _, v in  other_18  {
if ! hs.contains(v ,)  {
return false 
}
}
return true 
}

// IsProperSupersetOfSet determines whether a set is a proper superset of the specified 
pub fn (mut hs HashSet) is_proper_superset_of_set(other_19 HashSet) (bool, ) {return hs.is_proper_superset_of(other_19.keys() ,) 
}
