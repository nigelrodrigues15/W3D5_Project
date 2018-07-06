require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    @col ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @col[0].map { |el| el.to_sym }
  end

  # names.each do |name|
  #   define_method(name.to_sym) {instance_variable_get("@#{name}")}
  #   define_method("#{name}=") {|val| instance_variable_set("@#{name}", val)}
  # end
  def self.finalize!
    self.columns.each do |col_name|
      define_method("#{col_name}=") {|val| self.attributes[col_name] = val}
      define_method(col_name.to_sym) { self.attributes[col_name] }
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
    @table_name
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # debugger
    params.each do |k,v|
      raise "unknown attribute '#{k}'" unless self.class.columns.include?(k.to_sym)

      self.send(k.to_s+"=", v)
    end

  end

  def attributes
   @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
