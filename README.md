Demonstration of Phlex components with ability to inject before/after hooks.

As you can see, `PageBodyComponent` includes `Hookable` module which makes it
able to use additional class methods like `register_before_hook` and 
`register_after_hook`. These two allows user to inject his own components
in the hookable component and control the order of the injections with
simple before/after/replace hash syntax.

To use, run:

```ruby
PageBodyComponent.register_before_hook(:title, TitleComponent)
PageBodyComponent.register_before_hook(:date, DateComponent, before: :title)
PageBodyComponent.register_after_hook(:author, AuthorComponent)

pp ParentComponent.new.call
```
