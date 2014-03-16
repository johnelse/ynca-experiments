PROGRAM=watcher

$(PROGRAM): $(PROGRAM).ml
	ocamlfind ocamlopt unix.cmxa $(PROGRAM).ml -o $(PROGRAM)

clean:
	rm -f $(PROGRAM) *.cmi *.cmx *.o
