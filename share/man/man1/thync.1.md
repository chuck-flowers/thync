% THYNC(1) 0.0.0 | Theme Synchronizer

# NAME

thync - a tool for syncing themes across a system's programs

# SYNOPSIS

**thync** _<command>_

# DESCRIPTION

**thync** is a utility that allows for syncing theme variables between different applications. This is accomplished through the concepts of **VARIABLES** and **TARGETS**

A **VARIABLE** is a value that changes. A single variable is likely used by man plugins. For example, a color can be a variable. This allows the same color to be reused throughout applications on a single system. If the value of variable is updated, it will be applied to all applications which are binded to that variable.

A **TYPE** defines what kinds of values are allowed for a **VARIABLE** or **TARGET**. The following types are currently suppoorted by **thync**: color (e.g. _#ABCDEF_)

# FILES

**$XDG_CONFIG_HOME/thync/variables**
: The file that contains the currently defined variables

# EXAMPLES

**thync-vars** **define** _red_
: Defines the _red_ variable which implicitly has the type color

**thync-vars** **define** _height_ **-t** _number_
: Defines the _height_ variable with the type _number_

**thync-vars** **ls**
: Lists all defined variables, with their corresponding types and values

**thync-vars** **get** _red_
: Gets the value of the _red_ variable

**thync-vars** **get** _red_ -t
: Gets the type of the _red_ variable

**thync-vars** **set** _red_ _'#AA0000'_
: Sets the value of the _red_ variable to _#AA0000_

**thync-vars** **rm** _red_
: Deletes the _red_ variable

# SEE ALSO

**thync-vars(1)** **thync-targets(1)** **thync-bindings(1)** **thync-plugins(1)**

