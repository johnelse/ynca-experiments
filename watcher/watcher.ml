let default_port = 50000

let watch host port =
  let addr = Unix.ADDR_INET (Unix.inet_addr_of_string host, port) in
  let buffer = Bytes.create 1024 in
  let socket = Unix.socket Unix.PF_INET Unix.SOCK_STREAM 0 in
  Unix.connect socket addr;
  let rec watch' socket buffer =
    try
      let chars_received = Unix.recv socket buffer 0 1024 [] in
      let result = Bytes.sub buffer 0 chars_received in
      Printf.printf "%s%!" (Bytes.to_string result);
      watch' socket buffer
    with e ->
      Printf.printf ("%s was raised - shutting down\n%!") (Printexc.to_string e);
      Unix.shutdown socket Unix.SHUTDOWN_ALL
  in
  watch' socket buffer

let () =
  let host = ref None in
  let port = ref default_port in
  Arg.parse
    [
      ("-h", Arg.String (fun s -> host := Some s), "target IP address");
      ("-p", Arg.Set_int port, "target port");
    ]
    (fun arg -> Printf.printf "Argument %s not recognised\n" arg; exit 1)
    (Sys.executable_name ^ " -h <host -p <port>");
  match !host with
  | None -> Printf.printf "No host specified\n"; exit 1
  | Some host -> watch host !port
