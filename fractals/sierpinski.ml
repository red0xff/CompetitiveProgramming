(* Input format : two space separated integers h,depth
   h is the height of the grid
   depth is the depth of the triangle (number of iterations)
*)

let h, depth = Scanf.scanf "%d %d" (fun x y -> (x,y)) in
let w = 2*h - 1 in
let map = Array.make h (Bytes.empty) in

let print_map map = Array.iter (fun x->print_endline (Bytes.to_string x)) map in (* prints the grid *)

let rec init_map m = function (* initializes the grid *)
    | -1 -> ();
    | k -> m.(k) <- Bytes.make w '_';
                    Bytes.fill (map.(k)) (h-1-k) (2*k+1) '#';
                    init_map m (k-1)
                    in
init_map map (h-1); (* Initialize the map with a first triangle*)

let clear (x,y) (w,h) = (* pits a triangle inside the triangle that has width w, height h, and middle of base (x,y)*)
  let rec aux = function
  | 0 -> Bytes.fill map.(y+h-1) x 1 '_';
  | k -> Bytes.fill map.(y+h-k-1) (x-k) (2*k+1) '_'; aux (k-1) in
  aux (h/2-1) in

let rec draw (x,y) (w,h) = function (* recursively pit triangles on each iteration *)
  | 0 -> ();
  | k -> clear (x,y) (w,h); draw (x,y) (w/2,h/2) (k-1); draw (x-w/4-1,y+h/2) (w/2,h/2) (k-1); draw (x+w/4+1, y+h/2) (w/2,h/2) (k-1) in
draw (h-1, 0) (w, h) depth;

print_map map;
