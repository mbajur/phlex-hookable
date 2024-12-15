Demonstration of Phlex components with ability to inject before/after hooks.

As you can see, `PageBodyComponent` includes `Hookable` module which makes it
able to use additional class methods like `register_before_hook` and 
`register_after_hook`. These two allows user to inject his own components
in the hookable component and control the order of the injections with
simple before/after/replace hash syntax.

### Use-case

Aim of that is to make it able for gem UIs to be extendible by other gems.
Let's say you developed a Background processing UI rails engine. How can
other devs extend your UI from their own extension gems and, say, add additional
widgets to the dashboard without making them overwrite eachother? You can
potentialy extract your widgets area into some `DashboardWidgetsComponent` 
component, include `Hookable` and that's it - now other devs can inject their
widgets simply by calling a following line of code from inside their engine:

```ruby
DashboardWidgetsComponent.register_before_hook(:jbm, MyGem::JobsPerMinuteWidgetComponent)
```

### Usage

```ruby
pp ParentComponent.new.call
# => "<div>Header</div><div>My Article Body</div><div>Footer</div>"

PageBodyComponent.register_before_hook(:title, TitleComponent)
PageBodyComponent.register_before_hook(:date, DateComponent, before: :title)
PageBodyComponent.register_after_hook(:author, AuthorComponent)

pp ParentComponent.new.call
# => "<div>Header</div><h1>Posted 2 days ago</h1><h1>Welcome to my page</h1><div>My Article Body</div><small>by mbajur</small><div>Footer</div>"
```
