PROJECT_NAME := toggle-leds
SOURCES := $(git ls-tree --name-only -r HEAD)

build/$(PROJECT_NAME): $(SOURCES)
	jpm build
