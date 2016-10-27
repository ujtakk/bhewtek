open Printf

let rec rand_list upper n =
  match n with
    0 -> []
  | _ -> (Random.int upper)-upper/2 :: rand_list upper (n-1)

let write_list f l =
  let oc = open_out f in
  let rec int_iter oc l =
    match l with
      [] -> close_out oc;
    | x :: xs -> fprintf oc "%d\n" x; int_iter oc xs in
  int_iter oc l

let () =
  let seed = 2 in
  let range = 3 in
  Random.init seed;
  for i = 1 to 10000 do
    let file_x = "input/input_x_" ^ string_of_int i ^ ".dat" in
    let rand_x = rand_list range 25 in
    write_list file_x rand_x;

    let file_w = "input/input_w_" ^ string_of_int i ^ ".dat" in
    let rand_w = rand_list range 25 in
    write_list file_w rand_w;
  done
