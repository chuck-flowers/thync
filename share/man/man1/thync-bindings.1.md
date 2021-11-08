% THYNC-BINDINGS(1) 0.0.0 | Thync Bindings CLI

# NAME

thync-bindings - a util for interacting with thync's variable-target binding system

# SYNOPSIS

**thync-bindings** \[**ls**\] \[**-p** _plugin_\]

**thync-bindings** **add** _variable_ _plugin_ _target_

**thync-bindings** **rm** _plugin_ _target_

# DESCRIPTION

A binding refers to the application of a variables value to a plugin's target. Once a binding is created, any changes to the bound variable are automatically applied to all bound targets.

All usage of **thync-bindings** can also be accomplished with **thync bindings**.

# OPTIONS

## LS OPTIONS

**-p,--plugin**
: Only displays bindings for the specified plugin

# EXAMPLES

**thync-bindings**
: Lists all current bindings

**thync-bindings** **add** _background_ _xterm_ _background_
: Binds the thync variable _background_ to the _xterm_ plugin's target _background_.

**thync-bindings** **rm** _xterm_ _background_
: Removes any binding to the _xterm_ plugin's _background_ target.

# FILES

**$XDG_CONFIG_HOME/thync/bindings**
: The file containing all currently defined thync bindings

