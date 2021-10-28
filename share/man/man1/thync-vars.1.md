% THYNC-VARS(1) 0.0.0 | Thync Variable CLI

# NAME

thync-vars - a utility for interacting with thync's variable system

# SYNOPSIS

**thync-vars** **define** _name_ [**-t** { **color** | **number** }]

**thync-vars** **rm** _name_

**thync-vars** [ **ls** ]

**thync-vars** **get** _name_ [**-t**]

**thync-vars** **set** _name_ _value_

# DESCRIPTION

This CLI utility acts as a thin interface for modifying thync's variables file.
Instead of invoking **thync-vars** the user can also invoke **thync vars**.

# OPTIONS

## DEFINE OPTIONS

**-t**, **\-\-type**
: Specify the type of the variable being defined. If this option is omitted, **color** is assumed.

## GET OPTIONS

**-t**, **\-\-type**
: Specify that the type of the specified varible should be returned instead of the value

# FILES

**$XDG_CONFIG_HOME/thync/variables**
: The file that contains the variables, their types, and their values

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

