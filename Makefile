PREFIX ?= /usr

####################
# PROJECT PREFIXES #
####################

SRC_DIR=src
BUILD_DIR=build

####################
# SRC SCRIPT FILES #
####################

SRC_SCRIPT_DIR=$(SRC_DIR)/bin
SRC_SCRIPT_FILES=$(shell find $(SRC_SCRIPT_DIR) -maxdepth 1 -type f -executable)

####################
# SRC PLUGIN FILES #
####################

SRC_PLUGIN_DIR=$(SRC_DIR)/bin/plugins
SRC_PLUGIN_FILES=$(shell sed -E 's/^\s*#.*$$//' plugins-to-install | xargs -I{} echo $(SRC_PLUGIN_DIR)/thync-plugin-{} | tr '\n' ' ')

#################
# SRC MAN PAGES #
#################

SRC_MAN_DIR=$(SRC_DIR)/share/man
SRC_MAN_PAGES=$(shell find $(SRC_MAN_DIR) -type f)

#############################
# SRC BASH COMPLETION FILES #
#############################

SRC_BASH_COMPLETION_DIR=$(SRC_DIR)/share/bash-completion
SRC_BASH_COMPLETION_FILES=$(wildcard $(SRC_BASH_COMPLETION_DIR)/completions/*)

###################
# BUILD BIN FILES #
###################

BUILD_BIN_DIR=$(BUILD_DIR)/bin
BUILD_SCRIPT_FILES=$(patsubst $(SRC_SCRIPT_DIR)/%, $(BUILD_BIN_DIR)/%, $(SRC_SCRIPT_FILES))
BUILD_PLUGIN_FILES=$(patsubst $(SRC_PLUGIN_DIR)/%, $(BUILD_BIN_DIR)/%, $(SRC_PLUGIN_FILES))

###################
# BUILD MAN PAGES #
###################

BUILD_MAN_DIR=$(BUILD_DIR)/share/man
BUILD_MAN_PAGES=$(patsubst $(SRC_MAN_DIR)/%.md, $(BUILD_MAN_DIR)/%.gz, $(SRC_MAN_PAGES))

###############################
# BUILD BASH COMPLETION FILES #
###############################

BUILD_BASH_COMPLETION_DIR=$(BUILD_DIR)/share/bash-completion
BUILD_BASH_COMPLETION_FILES=$(patsubst $(SRC_BASH_COMPLETION_DIR)/%, $(BUILD_BASH_COMPLETION_DIR)/%, $(SRC_BASH_COMPLETION_FILES))

#################
# BUILD RECIPES #
#################

.PHONY: all
all: $(BUILD_SCRIPT_FILES) $(BUILD_PLUGIN_FILES) $(BUILD_MAN_PAGES)

.PHONY: clean
clean:
	rm -rf $(BUILD_BIN_DIR)

$(BUILD_BIN_DIR)/%: $(SRC_SCRIPT_DIR)/%
	mkdir -p $(dir $@)
	shellcheck $^
	cp $^ $@

$(BUILD_BIN_DIR)/thync-plugin-%: $(SRC_PLUGIN_DIR)/thync-plugin-%
	mkdir -p $(dir $@)
	shellcheck $^
	cp $^ $@

$(BUILD_BASH_COMPLETION_DIR)/completions/%: $(SRC_BASH_COMPLETION_DIR)/completions/%
	mkdir -p $(dir $@)
	shellcheck $^
	cp $^ $@

#########################
# DOCUMENTATION RECIPES #
#########################

$(BUILD_MAN_DIR)/%.gz: $(SRC_MAN_DIR)/%.md
	mkdir -p $(dir $@)
	pandoc -sf markdown -t man $< | gzip -c > $@

######################
# INSTALLATION RULES #
######################

.PHONY: install
install: install-bin install-completions install-man

.PHONY: install-bin
install-bin: $(BUILD_SCRIPT_FILES) $(BUILD_PLUGIN_FILES)
	install -Dt $(PREFIX)/bin $(BUILD_SCRIPT_FILES) $(BUILD_PLUGIN_FILES)

.PHONY: install-completions
install-completions: $(BUILD_BASH_COMPLETION_FILES)
	find $(BUILD_BASH_COMPLETION_DIR) -type f -exec install -D {} $(PREFIX)/{} \;

.PHONY: install-man
install-man: $(BUILD_MAN_PAGES)
	find $(BUILD_MAN_DIR) -type f -name \*.gz -exec install -D {} $(PREFIX)/{} \;

########################
# UNINSTALLATION RULES #
########################

.PHONY: uninstall
uninstall: uninstall-bin uninstall-completions uninstall-man

.PHONY: uninstall-bin
uninstall-bin:
	rm -f $(addprefix $(PREFIX)/, $(BIN_FILES)) \; 

.PHONY: uninstall-completions
uninstall-completions:
	find $(SHR_DIR)/bash-completion -type f -exec rm $(PREFIX)/{} \;

.PHONY: uninstall-man
uninstall-man:
	find $(SHR_DIR)/man -type f -name \*.gz -exec rm $(PREFIX)/{} \;

