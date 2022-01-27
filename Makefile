PREFIX ?= /usr

# Directories
BIN_DIR=bin
SHR_DIR=share
SRC_DIR=src

# Bin Files
SRC_FILES=$(shell find $(SRC_DIR) -type f -executable)
BIN_FILES=$(addprefix $(BIN_DIR)/, $(basename $(notdir $(SRC_FILES))))

# Man Files
MD_PAGES=$(shell find $(SHR_DIR)/man -name *.md)
MAN_PAGES=$(patsubst %.md, %.gz, $(MD_PAGES))

# Documentation Rules
$(SHR_DIR)/%.gz: $(SHR_DIR)/%.md
	pandoc -sf markdown -t man $< | gzip -c > $@

# Build recipes
.PHONY: all
all: $(MAN_PAGES) $(BIN_FILES)

.PHONY: clean
clean:
	find $(SHR_DIR)/man -name \*.gz -delete
	rm -f $(BIN_FILES)

# Build rules
$(BIN_DIR)/%: $(SRC_FILES)
	shellcheck $^
	cp $^ $(BIN_DIR)

# Installation Rules
.PHONY: install
install: install-bin install-completions install-man

.PHONY: install-bin
install-bin: $(BIN_FILES)
	find $(BIN_DIR) -type f -executable -exec install -D {} $(PREFIX)/{} \;

.PHONY: install-completions
install-completions:
	find $(SHR_DIR)/bash-completion -type f -exec install -D {} $(PREFIX)/{} \;

.PHONY: install-man
install-man: $(MAN_PAGES)
	find $(SHR_DIR)/man -type f -name \*.gz -exec install -D {} $(PREFIX)/{} \;

# Uninstallation Rules
.PHONY: uninstall
uninstall:
	rm -f $(addprefix $(PREFIX)/, $(BIN_FILES)) \; 
	find $(SHR_DIR)/bash-completion -type f -exec rm $(PREFIX)/{} \;
	find $(SHR_DIR)/man -type f -name \*.gz -exec rm $(PREFIX)/{} \;

