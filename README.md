Demonstration of Phlex components with ability to inject before/after hooks.

To use, run:

```
PageBodyComponent.register_before_hook(:title, TitleComponent)
PageBodyComponent.register_before_hook(:date, DateComponent, before: :title)
PageBodyComponent.register_after_hook(:author, AuthorComponent)

pp ParentComponent.new.call
```
