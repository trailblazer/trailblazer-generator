# Trailblazer Generator
all basic commands have --help

## Single file generation
Concept name and class name are required and validated before going ahead with the generation.

Examples:
- `bin/trailblazer g operation post create` -> will return an class_name error
- `bin/trailblazer g operation Post Create` -> will create the file `app/concepts/post/operation/create.rb` using the `create` template
- `bin/trailblazer g operation Post YeahNah` -> will create the file `app/concepts/post/operation/yeah_nah.rb` using the `generic` template and showing a Notice message saying that template yeah_nah template is not found and a generic one is used

## Multi files generation
Concept name is required and default arrays are used to generate the files

Example:
- `bin/trailblazer g operation Post` -> will generate `index.rb`, `create.rb`, `show.rb` and `update.rb` in `app/concepts/post/operation`

## Options
### Use of layout:
option --layout allows to change the concept directory layout

Examples:
- `bin/trailblazer g operation Post Create --layout="singular"` -> will create the file `app/concepts/post/operation/create.rb` (which is the default)
- `bin/trailblazer g operation Post Create --layout="plural"` -> will create the file `app/concepts/post/operations/create.rb`

### Use of action:
option --action allows to use a specific template

Examples:
`bin/trailblazer g operation Post Create --actiom=index` -> will create the file `app/concepts/post/operation/create.rb` user the `index` template

If template is not found a Notice message saying that template yeah_nah template is not found and a generic one is used

### Use of view (only for commands cell, cells and concept):
option --view allows to generate the view with a specific template

Examples:
`bin/trailblazer g cell Post Create --view=slim` -> will create 2 files `app/concepts/post/cell/create.rb` and `app/concepts/post/view/create.slim`

### Use of stubs
option --stubs allows to set a custom folder where a template will searched for.
Requirements:
- `erb` file
- expected stubs folder to have cell, contract, operation, view structure

###TODO: Use of other options

## NOTE
This is a work in progress.

The main idea we want with generator in the end, is that it also generators what's inside your files for the most basic aspects, think of validations, etc.
