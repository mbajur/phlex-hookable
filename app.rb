require 'phlex'
require_relative './hooks_list'

class TitleComponent < Phlex::HTML
  def view_template
    h1 { "Welcome to my page" }
  end
end

class DateComponent < Phlex::HTML
  def view_template
    h1 { "Posted 2 days ago" }
  end
end

class AuthorComponent < Phlex::HTML
  def view_template
    small { "by mbajur" }
  end
end

module Hookable
  def self.included(base)
    base.class_variable_set(:@@before_hooks, HooksList.new)
    base.class_variable_set(:@@after_hooks, HooksList.new)

    base.extend(ClassMethods)
  end

  def before_template
    self.class.class_variable_get(:@@before_hooks).each { |item| render item.component_class.new }
    super
  end

  def after_template
    super
    self.class.class_variable_get(:@@after_hooks).each { |item| render item.component_class.new }
  end

  module ClassMethods
    [:before, :after].each do |key|
      define_method :"register_#{key}_hook" do |id, component_class, opts = {}|
        item = HooksList::Item.new(id, component_class)

        if opts[:before]
          method = :add_before
          opts = [opts[:before], item]
        elsif opts[:after]
          method = :add_after
          opts = [opts[:after], item]
        elsif opts[:replace]
          method = :replace
          opts = [opts[:replace], item]
        else
          method = :add
          opts = [item]
        end

        self.class_variable_get(:"@@#{key}_hooks").public_send(method, *opts)
      end
    end
  end
end

class PageBodyComponent < Phlex::HTML
  include Hookable

  def view_template
    div { "My Article Body" }
  end
end

class ParentComponent < Phlex::HTML
  def view_template
    div { "Header" }
    render PageBodyComponent.new
    div { "Footer" }
  end
end
