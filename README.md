# Trailblazer Generator
all basic commands have --help

## Single file generation

Available commands: `cell`, `contract`, `finder` and `operation`

Concept name and class name are required and validated before going ahead with the generation.

Examples:
- `bin/trailblazer g operation post create` -> will return an class_name error
- `bin/trailblazer g operation Post Create` -> will create the file `app/concepts/post/operation/create.rb` using the `create` template
- `bin/trailblazer g operation Post YeahNah` -> will create the file `app/concepts/post/operation/yeah_nah.rb` using the `generic` template and showing a Notice message saying that template yeah_nah template is not found and a generic one is used

The `cell` and `cells` commands will create also the corrispective view file unless option --view is set to `none`.
Examples:
- `bin/trailblazer g cell Post New` -> will create 2 files `app/concepts/post/cell/new.rb` and `app/concepts/post/view/new.slim`
- `bin/trailblazer g cell Post New --view=none` -> will create 1 file only `app/concepts/post/cell/new.rb`

## Multi files generation

Available commands: `concept`, `cells` and `operations`

Concept name is required and default arrays are used to generate the files

Example:
- `bin/trailblazer g operation Post` -> will generate `index.rb`, `create.rb`, `show.rb` and `update.rb` in `app/concepts/post/operation`

## Options
### layout:
option `
--layout` allows to change the concept directory layout

Examples:
- `bin/trailblazer g operation Post Create --layout="singular"` -> will create the file `app/concepts/post/operation/create.rb` (which is the default)
- `bin/trailblazer g operation Post Create --layout="plural"` -> will create the file `app/concepts/post/operations/create.rb`

### action:
option `--action` allows to use a specific template

Examples:
- `bin/trailblazer g operation Post Create --actiom=index` -> will create the file `app/concepts/post/operation/create.rb` user the `index` template

If template is not found a Notice message saying that template yeah_nah template is not found and a generic one is used

### view (only for commands cell, cells and concept):
option `--view` allows to generate the view with a specific template (default slim), when passing --view=none the view file is not created

Examples:
- `bin/trailblazer g cell Post Create --view=erb` -> will create 2 files `app/concepts/post/cell/create.rb` and `app/concepts/post/view/create.slim`

### TODO: other options

## NOTE
This is a work in progress.

The main idea we want with generator in the end, is that it also generators what's inside your files for the most basic aspects, think of validations, etc.
