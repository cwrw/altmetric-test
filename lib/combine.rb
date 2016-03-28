require "csv"
require "json"
require 'optparse'
require "./lib/combine/input_parser"
require "./lib/combine/input_parser/articles_parser"
require "./lib/combine/input_parser/authors_parser"
require "./lib/combine/input_parser/journals_parser"
require "./lib/combine/formatter/json_formatter"
require "./lib/combine/formatter/csv_formatter"
require "./lib/combine/record"
require "./lib/combine/base"

require "./lib/combine/exceptions"
require "pry-byebug"
