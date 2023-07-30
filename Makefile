CC = gcc
CFLAGS = -Wall -Wextra -std=c11

SRC_DIR = ./src/
OBJ_DIR = ./obj/
BIN_DIR = ./bin/
CONF_DIR = ./config/

SOURCES = $(wildcard $(SRC_DIR)*.c)
OBJECTS = $(addprefix $(OBJ_DIR), $(notdir $(SOURCES:.c=.o)))
EXECUTABLE = stupidlayers
UDEV_CONFIG_SRC = $(wildcard $(CONF_DIR)*.rules)

DESTDIR ?= 
BIN_DEST ?= $(DESTDIR)/usr/local/bin/
UDEV_CONFIG_DEST ?= $(DESTDIR)/etc/udev/rules.d/

INSTALL = install -m 0755
INSTALL_CONFIG = install -m 0644

.PHONY: all clean install uninstall directories config

ifeq ($(strip $(UDEV_CONFIG_SRC)),)
$(error No config files found)
endif

all: directories $(BIN_DIR)$(EXECUTABLE)

directories: $(OBJ_DIR) $(BIN_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

install: $(BIN_DIR)$(EXECUTABLE) config
	mkdir -p $(BIN_DEST)
	$(INSTALL) $(BIN_DIR)$(EXECUTABLE) $(BIN_DEST)$(EXECUTABLE)

uninstall:
	rm -f $(BIN_DEST)$(EXECUTABLE)
	rm -f $(UDEV_CONFIG_DEST)$(notdir $(UDEV_CONFIG_SRC))

config:
	mkdir -p $(UDEV_CONFIG_DEST)
	$(foreach cfg, $(UDEV_CONFIG_SRC), $(INSTALL_CONFIG) $(cfg) $(UDEV_CONFIG_DEST);)

clean:
	rm -f $(OBJ_DIR)*.o
	rm -f $(BIN_DIR)$(EXECUTABLE)

$(BIN_DIR)$(EXECUTABLE): $(OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	$(CC) $(CFLAGS) -c $< -o $@
