PROJECT_NAME := toggle-leds
SOURCES := $(git ls-tree --name-only -r HEAD)
TARGET := build/$(PROJECT_NAME)
CHMOD := chmod u+s $(TARGET)

$(TARGET): $(SOURCES)
	jpm build
	@{ \
		if [ $(shell id -u) -eq 0 ]; then \
			$(CHMOD); \
		else \
			sudo $(CHMOD); \
		fi; \
	}
