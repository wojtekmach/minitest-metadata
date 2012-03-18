# minitest-metadata

* https://github.com/wojtekmach/minitest-metadata

## Description

minitest-metadata allows you to set metadata (key-value) for your test cases so that
before and after hooks can use them.

You can use it to:

* change environments (prepare drivers, mocks etc)
* mark tests as slow, fast or (God forbid) order dependant

## Example

Suppose you want to tag some of your Capybara acceptance tests to
use JavaScript driver


```ruby
class AcceptanceTest < MiniTest::Spec
  include Capybara::DSL

  before do
    if metadata[:js] == true
      Capybara.current_driver = Capybara.javascript_driver
    end
  end

  after do
    Capybara.current_driver = Capybara.default_driver
  end
end

class UsersAcceptanceTest < AcceptanceTest
  it "basic pagination" do
    visit "/users"
    assert page.has_content?("Current page: 1")

    click_link "Next page"

    assert page.has_content?("Current page: 2")
  end

  it "keyboard shortcuts pagination", :js => true do
    visit "/users"
    assert page.has_content?("Current page: 1")

    press_key "n"

    assert page.has_content?("Current page: 2")
  end
end
```


## Requirements

* minitest

## Instalation

    gem install minitest-metadata

or put in a Gemfile

    gem 'minitest-metadata'

## License

(The MIT License)

Copyright (c) 2012 Wojciech Mach

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
