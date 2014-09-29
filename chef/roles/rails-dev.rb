name "rails-dev"
description "setup for ruby on rails core development"
run_list(
  "recipe[apt]",
  "recipe[git]",
  "recipe[postgresql::ruby]",
  "recipe[postgresql::server]",
  "recipe[nodejs::install_from_binary]",
  "recipe[ruby_build]",
  "recipe[rbenv::system]",
  "recipe[rbenv::vagrant]",
  "recipe[database]",
  "recipe[postinstall]"
)
default_attributes(
  "build_essential" => {
    "compiletime" => true
  }
)