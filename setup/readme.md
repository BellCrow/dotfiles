# Setup
This setup should contain everything needed to setup a new 
linux box (debian based) from scratch in order to start working with
for me. 

It should install the tools, lsp, formatter, linters etc, that im using. 
For that I will prefer to use package managers, as they are easier to 
script. However I will fall back to downloading and unpacking zip files
if need be. 

The setup is structured in the following way:

# Entry point
*setup.sh* is the main entry point. I should be able to just call this 
whenever and it should add missing programs and settings to the correct places.

# Files
Other than that there is one file for each topic. That would be 
one file for all python related topics, one for rust, etc.

# Version management
I will strife to the best of my abilities to always use a fixed version 
of a software. That way I will have nice reproducibility on all machines.

# Machine flags
As im using this config on more than one machine I will add checks for the
following environment flags:

* MACHINE_PERSONAL
* MACHINE_BUSINESS

Software, that should only be installed on only one of these machines should
check for the presence of these flags beforehand.
No check is needed if the software should be installed on all machine types.

E.g. I'll always be using nvim, but perhaps not c#.
