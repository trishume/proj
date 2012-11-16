# Proj

`proj` is a command line tool for managing projects. 
It integrates with Git and Github to allow you to easily 
create new projects, run tasks and upload projects to Github.

## Installation

Add this line to your application's Gemfile:

    gem 'proj'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install proj

## Usage

The `proj` command can be used to create projects and perform actions on existing projects.
Commands often have interactive prompts but default values are configurable and
the prompts can be disabled.

`proj` uses two different config files:
- `~/.projrc.yml` stores global configuration
- `projects.yml` can be located anywhere and stores data on the different
projects. This file is managed by proj but can be hand-edited to take advantage
of extra functionality.

### The projects.yml file

The projects.yml file has a root key named `projects` that is a YAML dictionary 
where the keys are project names and the values are project attributes.

Possible attributes:
- folder: the path to the folder that contains this project's folder. For
  example if the project is named doubleVision and the folder attribute is set
  to `~/Development` the project's folder will be located at
  `~/Development/doubleVision`
- github: A boolean attribute specifying if this project has an associated
  Github repo of the same name.
- tasks: A ist of possible tasks such as building, see the Tasks section for
  more info.

#### Configuration

The location of the projects.yml file can be set using the `projects_file`
attribute in `~/.projrc.yml`.

Example:

  projects\_file: ~/Dropbox/coding/projects.yml

### Creating a New Project 

New projects are created using the `proj new` command. It works like this:

  $ proj new projName
  Project folder location [folder path or blank for ~/Development]:
  Create a Github repo [Y/N]: Y
  Project created, look in projects.yml for more detailed settings.

#### Configuration

Configuration for the new functionality is found under the `new_projects` key in
`~/.projrc.yml`. The key contains a dictionary of new project properties and
default values.

Each key of `new_projects` corresponds to a key for the project in the
projects.yml file. The keys that can be used under a property in `new_projects` are:
- default: The default value used for that project key.
- ask: wether to interactively prompt the user for the value or simply use the
  default. Defaults to true if omitted.
- aliases: a dictionary of aliased values. If one of the keys is entered at the
  prompt the value will be substituted in. Defaults to nothing if omitted.

Example:

  new\_projects:
    folder:
      default: ~/Development
      aliases:
        webdev: ~/Development/Webdev
        work: ~/WorkDev
      # don't ask where to put it
      ask: false
    github:
      default: true
      aliases:
        Y: true
        N: false
    # ...


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
