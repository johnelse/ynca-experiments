COMPONENTS=watcher

.PHONY: all clean

all:
	$(foreach COMPONENT, $(COMPONENTS), $(MAKE) -C $(COMPONENT);)

clean:
	$(foreach COMPONENT, $(COMPONENTS), $(MAKE) -C $(COMPONENT) clean;)
