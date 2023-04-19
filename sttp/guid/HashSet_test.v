module guid
import github.com.sttp.goapi.sttp.hashset as .
const empty=Guid{} 
fn random() (Guid, ) {return new() 
}

pub fn test_new_hash_set(t &testing.T) {mut set:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
if set .len  !=  4  {
t.fatalf("NewHashSet: len != 4" ,)
}
}

pub fn test_add(t_1 &testing.T) {mut set:=new_hash_set([]Guid{} ,)  
set.add(random() ,)
set.add(random() ,)
if set.add(set.keys[0 ] ,) {
t_1.fatalf("Add: Inserted duplicated %s" ,set.keys[0 ] ,)
}
if set .len  !=  2  {
t_1.fatalf("Add: len != 2" ,)
}
}

pub fn test_remove(t_2 &testing.T) {mut set:=new_hash_set([]Guid{} ,)  
set.add(random() ,)
set.add(random() ,)
mut item:=random()  
set.add(item ,)
if ! set.remove(item ,)  {
t_2.fatalf("Remove: Failed to remove %s" ,item ,)
}
if set .len  !=  2  {
t_2.fatalf("Remove: len != 2" ,)
}
}

pub fn test_remove_where(t_3 &testing.T) {mut set:=new_hash_set([]Guid{} ,)  
set.add(random() ,)
set.add(random() ,)
set.add(empty ,)
set.add(empty ,)
mut count:=set.remove_where(fn (item Guid) (bool, ) {return item  ==  empty  
}
 ,) 
if count  !=  1  {
t_3.fatalf("RemoveWhere: Failed to remove" ,)
}
if set .len  !=  2  {
t_3.fatalf("RemoveWhere: len != 2" ,)
}
}

pub fn test_is_empty(t_4 &testing.T) {mut set:=new_hash_set([]Guid{} ,)  
if ! set.is_empty()  {
t_4.fatalf("IsEmpty: Set not empty" ,)
}
}

pub fn test_clear(t_5 &testing.T) {mut set:=new_hash_set([random() ,random() ,random() ] ,)  
set.clear()
if ! set.is_empty()  {
t_5.fatalf("Clear: Set not empty" ,)
}
}

pub fn test_contains(t_6 &testing.T) {mut set:=new_hash_set([]Guid{} ,)  
set.add(random() ,)
set.add(random() ,)
mut item:=random()  
set.add(item ,)
if ! set.contains(item ,)  {
t_6.fatalf("Contains: Failed to find %s" ,item ,)
}
}

pub fn test_keys(t_7 &testing.T) {mut set:=new_hash_set([]Guid{} ,)  
set.add(random() ,)
set.add(random() ,)
mut item:=random()  
set.add(item ,)
mut keys:=set.keys()  
mut found:=false  
for _, v in  keys  {
if v  ==  item  {
found=true  
break 
}
}
if ! found  {
t_7.fatalf("Keys: Failed to find key %s" ,item ,)
}
}

pub fn test_except_with_set(t_8 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
set1.add(random() ,)
set2.add(random() ,)
set1.except_with_set(set2 ,)
if set1 .len  !=  1  {
t_8.fatalf("ExceptWith: len != 1" ,)
}
}

pub fn test_symmetric_except_with_set(t_9 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
mut set3:=NOT_YET_IMPLEMENTED  
set3.symmetric_except_with_set(set1 ,)
if ! set1.set_equals_set(set3 ,)  {
t_9.fatalf("SymmetricExceptWith: sets not equal" ,)
}
set1.add(random() ,)
set2.add(random() ,)
set1.symmetric_except_with_set(set2 ,)
if set1 .len  !=  2  {
t_9.fatalf("SymmetricExceptWith: len != 2" ,)
}
}

pub fn test_intersect_with_set(t_10 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
mut set3:=new_hash_set(set1.keys() ,)  
set1.add(random() ,)
set2.add(random() ,)
set1.intersect_with_set(set2 ,)
if ! set1.set_equals_set(set3 ,)  {
t_10.fatalf("IntersectWith: Sets not equal" ,)
}
mut set4:=NOT_YET_IMPLEMENTED  
set4.intersect_with(set1.keys() ,)
if set4 .len  !=  0  {
t_10.fatalf("IntersectWith: empty set intersect caused change" ,)
}
set1.intersect_with(set4.keys() ,)
if set1 .len  !=  0  {
t_10.fatalf("IntersectWith: insertsect with empty set should be zero" ,)
}
}

pub fn test_union_with_set(t_11 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
mut set3:=new_hash_set(set1.keys() ,)  
mut item1:=random()  
set1.add(item1 ,)
mut item2:=random()  
set2.add(item2 ,)
set1.union_with_set(set2 ,)
if ! set1.contains(item1 ,)  {
t_11.fatalf("UnionWith: Missing  item1" ,)
}
if ! set1.contains(item2 ,)  {
t_11.fatalf("UnionWith: Missing  item2" ,)
}
set3.union_with_set(set1 ,)
if ! set1.set_equals_set(set3 ,)  {
t_11.fatalf("UnionWith: Sets not equal" ,)
}
}

pub fn test_set_equals_set(t_12 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
if ! set1.set_equals_set(set2 ,)  {
t_12.fatalf("SetEquals: Sets not equal" ,)
}
mut keys:=set1.keys()  
mut first:=keys[0 ]  
if ! set1.remove(first ,)   ||  ! set2.remove(first ,)   {
t_12.fatalf("SetEquals: Failed to remove" ,)
}
if ! set1.set_equals_set(set2 ,)  {
t_12.fatalf("SetEquals: Sets not equal" ,)
}
first=set2.keys[0 ]  
if ! set2.remove(first ,)  {
t_12.fatalf("SetEquals: Failed to remove first key" ,)
}
set2.add(random() ,)
if set1 .len  !=  set2 .len  {
t_12.fatalf("SetEquals: Set lengths are unequal" ,)
}
if set1.set_equals(set2.keys() ,) {
t_12.fatalf("SetEquals: Same length unequal sets are equal" ,)
}
set2.add(random() ,)
if set1.set_equals(set2.keys() ,) {
t_12.fatalf("SetEquals: Different length unequal sets are equal" ,)
}
}

pub fn test_overlaps_set(t_13 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
if ! set1.overlaps_set(set2 ,)  {
t_13.fatalf("Overlaps: Sets do not overlap" ,)
}
if ! set1.remove(set1.keys[0 ] ,)  {
t_13.fatalf("Overlaps: Failed to remove" ,)
}
if ! set1.overlaps_set(set2 ,)  {
t_13.fatalf("Overlaps: Sets do not overlap" ,)
}
set2.add(random() ,)
if ! set1.overlaps_set(set2 ,)  {
t_13.fatalf("Overlaps: Sets do not overlap" ,)
}
if ! set2.overlaps_set(set1 ,)  {
t_13.fatalf("Overlaps: Sets do not overlap" ,)
}
mut set3:=NOT_YET_IMPLEMENTED  
if set3.overlaps(set1.keys() ,) {
t_13.fatalf("Overlaps: Sets overlap" ,)
}
set3.add(random() ,)
set3.add(random() ,)
if set3.overlaps(set1.keys() ,) {
t_13.fatalf("Overlaps: Sets overlap" ,)
}
}

pub fn test_is_subset_of_set(t_14 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
if ! set1.is_subset_of_set(set2 ,)  {
t_14.fatalf("IsSubsetOf: Set is not subset" ,)
}
if ! set1.remove(set1.keys[0 ] ,)  {
t_14.fatalf("IsSubsetOf: Failed to remove" ,)
}
if ! set1.is_subset_of_set(set2 ,)  {
t_14.fatalf("IsSubsetOf: Set is not subset" ,)
}
set2.add(random() ,)
if ! set1.is_subset_of_set(set2 ,)  {
t_14.fatalf("IsSubsetOf: Set is not subset" ,)
}
if set2.is_subset_of_set(set1 ,) {
t_14.fatalf("IsSubsetOf: Set is not expected to be subset" ,)
}
mut set3:=NOT_YET_IMPLEMENTED  
if ! set3.is_subset_of(set1.keys() ,)  {
t_14.fatalf("IsSubsetOf: Empty set is not a subset" ,)
}
set3.add(random() ,)
set3.add(random() ,)
if set3.is_subset_of(set1.keys() ,) {
t_14.fatalf("IsSubsetOf: Unequal set is a subset" ,)
}
}

pub fn test_is_proper_subset_of_set(t_15 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
if set1.is_proper_subset_of_set(set2 ,) {
t_15.fatalf("IsProperSubsetOf: Set is not expected to be proper subset" ,)
}
if ! set1.remove(set1.keys[0 ] ,)  {
t_15.fatalf("IsProperSubsetOf: Failed to remove" ,)
}
if ! set1.is_proper_subset_of_set(set2 ,)  {
t_15.fatalf("IsProperSubsetOf: Set is not proper subset" ,)
}
set2.add(random() ,)
if ! set1.is_proper_subset_of_set(set2 ,)  {
t_15.fatalf("IsProperSubsetOf: Set is not proper subset" ,)
}
if set2.is_proper_subset_of_set(set1 ,) {
t_15.fatalf("IsProperSubsetOf: Set is not expected to be proper subset" ,)
}
mut set3:=NOT_YET_IMPLEMENTED  
if ! set3.is_proper_subset_of(set1.keys() ,)  {
t_15.fatalf("IsSubsetOf: Empty proper set is not a subset" ,)
}
set3.add(random() ,)
set3.add(random() ,)
if set3.is_proper_subset_of(set1.keys() ,) {
t_15.fatalf("IsSubsetOf: Unequal set is a proper subset" ,)
}
}

pub fn test_is_superset_of_set(t_16 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
if ! set2.is_superset_of_set(set1 ,)  {
t_16.fatalf("IsSupersetOf: Set is not superset" ,)
}
if ! set1.remove(set1.keys[0 ] ,)  {
t_16.fatalf("IsSupersetOf: Failed to remove" ,)
}
if ! set2.is_superset_of_set(set1 ,)  {
t_16.fatalf("IsSupersetOf: Set is not superset" ,)
}
set2.add(random() ,)
if ! set2.is_superset_of_set(set1 ,)  {
t_16.fatalf("IsSupersetOf: Set is not superset" ,)
}
if set1.is_superset_of_set(set2 ,) {
t_16.fatalf("IsSupersetOf: Set is not expected to be superset" ,)
}
mut set3:=NOT_YET_IMPLEMENTED  
if ! set1.is_superset_of(set3.keys() ,)  {
t_16.fatalf("IsSupersetOf: Empty set is not a superset" ,)
}
set3.add(random() ,)
set3.add(random() ,)
if set1.is_superset_of(set3.keys() ,) {
t_16.fatalf("IsSubsetOf: Unequal set is a superset" ,)
}
}

pub fn test_is_proper_superset_of_set(t_17 &testing.T) {mut set1:=new_hash_set([random() ,random() ,random() ,random() ] ,)  
mut set2:=new_hash_set(set1.keys() ,)  
if set2.is_proper_superset_of_set(set1 ,) {
t_17.fatalf("IsProperSupersetOf: Set is not expected to be proper superset" ,)
}
if ! set1.remove(set1.keys[0 ] ,)  {
t_17.fatalf("IsProperSupersetOf: Failed to remove" ,)
}
if ! set2.is_proper_superset_of_set(set1 ,)  {
t_17.fatalf("IsProperSupersetOf: Set is not proper superset" ,)
}
set2.add(random() ,)
if ! set2.is_proper_superset_of_set(set1 ,)  {
t_17.fatalf("IsProperSupersetOf: Set is not proper superset" ,)
}
if set1.is_proper_superset_of_set(set2 ,) {
t_17.fatalf("IsProperSupersetOf: Set is not expected to be proper superset" ,)
}
mut set3:=NOT_YET_IMPLEMENTED  
if ! set1.is_proper_superset_of(set3.keys() ,)  {
t_17.fatalf("IsSupersetOf: Empty set is not a proper superset" ,)
}
if ! set3.is_proper_superset_of(set1.keys() ,)  {
t_17.fatalf("IsSupersetOf: Empty set is not a proper superset" ,)
}
set3.add(random() ,)
set3.add(random() ,)
if set1.is_proper_superset_of(set3.keys() ,) {
t_17.fatalf("IsSubsetOf: Unequal set is a proper superset" ,)
}
}
