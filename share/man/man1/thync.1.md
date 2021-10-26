% THYNC(1) 0.0.0 | Theme Synchronizer

# NAME

thync - a tool for syncing themes across a system's programs

# SYNOPSIS

**thync** **vars** **define** _name_ [**-t** { **color** | **number** }]

**thync** **vars** **get** [**-t**] _name_

**thync** **vars** **set** _name_ _value_

**thync** **profiles** **add** _name_

**thync** **profiles** **rm** _name_

**thync** **profiles** **set** _name_

**thync** **plugins** [**-t**]

**thync** **targets** **get** _plugin_

**thync** **bindings** **add** _variable_ _plugin_ _target_

**thync** **bindings** **rm** _plugin_ _target_


# DESCRIPTION

**thync** is a utility that allows for syncing theme variables between different applications. This is accomplished through the concepts of **VARIABLES** and **TARGETS**

A **TARGET** is something which can be set to a variable. Targets are defined by plugins and have a specified type.

A **VARIABLE** is a value that changes. A single variable is likely used by man plugins. For example, a color can be a variable. This allows the same color to be reused throughout applications on a single system. If the value of variable is updated, it will be applied to all applications which are **binded** to that variable.

A **TYPE** defines what kinds of values are allowed for a **VARIABLE** or **TARGET**.

The following types are currently suppoorted by **thync**:

* Color
	* Hex Format (e.g. #ABCDEF)
* Number
	* Base 10 (e.g. 16)
	* Base 16 (e.g. 0x10)

# OPTIONS

## VARS DEFINE OPTIONS

**-t**, **\-\-type**

: Specify the type of the variable being defined. If unset, **color** is assumed

## VARS GET OPTIONS

**-t**, **\-\-type**

: Reports the type of the specified variable instead of the value

## PLUGINS OPTIONS

**-t**, **\-\-targets**

: Also output the targets that each plugin provides

# FILES

**$XDG_CONFIG_HOME/thync/variables**

: The file that contains the currently defined variables

**$XDG_CONFIG_HOME/thync/bindings**

: The file that contains the currently defined bindings

**$XDG_CONFIG_HOME/thync/profiles**

: A directory containing the user's defined profiles

# EXAMPLES

**thync** **vars** **define** _darkRed_ color

: Defines the variable _darkRed_ with the type color

**thync** **vars** **get** _darkRed_

: Shows the value of the _darkRed_ variable

**thync** **vars** **set** _darkRed_ _#AA0000_

: Updates the value of the _darkRed_ variable to _#AA0000_

**thync** **plugins**

: Shows all thync plugins that are currently installed

**thync** **targets** **get** _Xresources_

: Gets all the available targets for the _Xresources_ plugin

**thync** **bind** _darkRed_ _Xresources_ _red_

: Synchronizes the _Xresources_ plugin's _red_ target with thync's _darkRed_ variable

**thync** **unbind** _Xresources_ _red_

: Desynchronizes the _Xresources_ plugin's _red_ variable from thync's managment

