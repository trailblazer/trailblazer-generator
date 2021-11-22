# Trailblazer Generator
Master: [![Build Status](https://travis-ci.org/trailblazer/trailblazer-generator.svg)](https://travis-ci.org/trailblazer/trailblazer-generator)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trailblazer-generator', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trailblazer-generator

## Single file generation

Available commands: `cell`, `contract`, `finder`, `operation` and `activity`.

Concept name and class name are required and validated before going ahead with the generation.

Examples:
- `trailblazer g operation post create` -> will return an class_name error
- `trailblazer g operation Post Create` -> will create the file `app/concepts/post/operation/create.rb` using the `create` template
- `trailblazer g operation Post Custom` -> will create the file `app/concepts/post/operation/custom.rb` using the `generic` template and showing a Notice message saying that template custom template is not found and a generic one is used

The `cell` and `cells` commands will create also the corrispective view file unless option `--view` is set to `none`.
Examples:
- `trailblazer g cell Post New` -> will create 2 files `app/concepts/post/cell/new.rb` and `app/concepts/post/view/new.slim`
- `trailblazer g cell Post New --view=none` -> will create 1 file only `app/concepts/post/cell/new.rb`

## Multi files generation

Available commands: `concept`, `cells` and `operations`

Concept name is required and default arrays are used to generate the files

Example:
- `trailblazer g operations Post` -> will generate `index.rb`, `create.rb`, `show.rb` and `update.rb` in `app/concepts/post/operation`

## Options
### `--layout`
`plural` and `singular` (default one) are the possible options

Examples:
- `trailblazer g operation Post Create --layout=singular` -> will create the file `app/concepts/post/operation/create.rb` (which is the default)
- `trailblazer g operation Post Create --layout=plural` -> will create the file `app/concepts/post/operations/create.rb`

### `--template`
allows to use a specific existing template

Examples:
- `trailblazer g operation Post Create --actiom=index` -> will create the file `app/concepts/post/operation/create.rb` user the `index` template

If template is not found a Notice message saying that index template is not found and a generic one is used

### `--stubs`
allows to pass a custom folder as source where the template will be searched into

Requirements:
- `erb` file
- expected stubs folder to have cell, contract, operation, view structure

### `--view` (only for commands cell, cells and concept):
allows to generate the view file with a template engine other than the default `erb`, when passing `--view=none` the view file will not be created

Examples:
- `trailblazer g cell Post Create --view=slim` -> will create 2 files `app/concepts/post/cell/create.rb` and `app/concepts/post/view/create.slim`

### `--path`
allows to specify a different destination folder for the generating file (available in all commands)

- `trailblazer g operation Post Create --path=custom_path` -> will create 1 file `custom_path/post/operation/create.rb`

### `--add_type_to_namespace` (except for commands cell, cells and concept)
allows to add/remove the type (operation, contract,...) from the generate class namespace and the file destination path.
It's a boolean option so:
- `--add_type_to_namespace` -> `true`
- `--no-add_type_to_namespace` -> `false`

Example:
- `trailblazer g operation Post Crete --no-add_type_to_namespace` -> will create an operation with namespace `Post::Create` in `app/concepts/post/create.rb`

### `--app_dir`
allows to change the application folder

Example:
- `trailblazer g concept Post --app_dir=anything` -> will create a `Post` concept inside anything `anything/concepts/post`

### `--concepts_folder`
allows to change the concepts folder

Example:
- `trailblazer g concept Post --concepts_folder=anything` -> will create a `Post` concept inside using anything as concepts folder `app/anything/post`

### `--activity_strategy` (only for `activity` command)
allows to select which strategy to use.
Supported strategies: `path`, `fast_track` and `railway`

Example:
- `trailblazer g activity Post Create --activity_strategy=railway` -> will create an `Activity` in `app/concepts/activity/create.rb` adding `extend Trailblazer::Activity::Railway()`

### Settings file
It's possible to override the default options also using a `trailblazer_generator.yml` file saved in the root path of your application.

Available keys:
```
view: slim
stubs: anything
add_type_to_namespace: false
app_folder: anything
concepts_folder: anything
activity_strategy: only_supported_ones (path, fast_track and railway)
file_list:
  operation: [new, create]
  cell: [custom, custom2]
  contract: []
  finder: []
  view: []
  activity: []
```

All the keys needs to be a string instead the nested keys under `file_list` must be an array of string otherwise a warning message will be shown and the file will not be used.

The keys under `file_list` are the default template used to create files and are also used to loop through to create multiple files, the combination of `stubs` and those keys will allow you to set up a new templates set.

## NOTE
This is a work in progress.

The main idea we want with generator in the end, is that it also generates what's inside your files for the most basic aspects, think of validations, etc.
