# Trailblazer Generator
Master: [![Build Status](https://travis-ci.org/trailblazer/trailblazer-generator.svg)](https://travis-ci.org/trailblazer/trailblazer-generator)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trailblazer-generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trailblazer-generator

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
### `--layout`
`plural` and `singular` (default one) are the possible options

Examples:
- `bin/trailblazer g operation Post Create --layout="singular"` -> will create the file `app/concepts/post/operation/create.rb` (which is the default)
- `bin/trailblazer g operation Post Create --layout="plural"` -> will create the file `app/concepts/post/operations/create.rb`

### `--template`
allows to use a specific existing template

Examples:
- `bin/trailblazer g operation Post Create --actiom=index` -> will create the file `app/concepts/post/operation/create.rb` user the `index` template

If template is not found a Notice message saying that template yeah_nah template is not found and a generic one is used

### `--stubs`
allows to pass a custom folder as source where the template will be searched into

Requirements:
- `erb` file
- expected stubs folder to have cell, contract, operation, view structure

### `--view` (only for commands cell, cells and concept):
allows to generate the view file with a template engine other than the default `erb`, when passing `--view=none` the view file will not be created

Examples:
- `bin/trailblazer g cell Post Create --view=erb` -> will create 2 files `app/concepts/post/cell/create.rb` and `app/concepts/post/view/create.slim`

### `--path`
allows to specify a different destination folder for the generating file (available in all commands)

- `bin/trailblazer g operation Post Create --path=custom_path` -> will create 1 file `custom_path/post/operation/create.rb`

### `--add_type_to_namespace` (except for commands cell, cells and concept)
allows to add/remove the type (operation, contract,...) from the generate class namespace and the file destination path.
It's a boolean option so:
- `--add_type_to_namespace` -> `true`
- `--no-add_type_to_namespace` -> `false`

Example:
- `bin/trailblazer g operation Post Crete --no-add_type_to_namespace` -> will create an operation with namespace `Post::Create` in `app/concepts/post/create.rb`

### `--json`
generates code
TODO: more info and example for this


## NOTE
This is a work in progress.

The main idea we want with generator in the end, is that it also generates what's inside your files for the most basic aspects, think of validations, etc.

#### For developers
Using the `abort` method in `Trailblazer::Generator::Utils::Error` class can abort the test suite as well so make sure to handle any rasing errors!!!
