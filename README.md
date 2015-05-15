
# P10 Build Something Beautiful

##Learning Competencies

  * Building a web application from scratch
  * Managing the development process
  *

##Summary

  You've learned a lot in phase 2: Sinatra, Active Record, Heroku, RSpec, JavaScript, Agile, and much more. Each of these tools is useful in its own right, but together, they give you something much more powerful — the ability to build a web application from nothing.

  For this challenge, your assignment is to build something. It can be as practical or trivial as you would want, as long as its a 100% functional, full-stack web application.

##Releases


###Release 0: Decide on What to Build

You can build anything you want, provided that it meets the following requirements:

- It has a database
- It uses an API
- It is styled
- It utilizes JavaScript
- It has meaningful test coverage
- It is deployed

Once you've come up with an idea, get one of your teachers to approve it.

###Release 1: Build it

Once apporoved, start building your project. Be sure to submit a link to where we
can see your site live.

> **Note**: This branch (master) contains a skeleton without any app code, perfect for creating a _new_ application or challenge. If you're looking for an example app built with this skeleton, take a look at the [example](/../..//tree/example) branch which includes basic CRUD and RSpec tests.

### Purpose
The Sinatra Skeleton:

1. Provides a foundation for building challenges or creating a new Sinatra application.
2. Demonstrates a reasonable set of practices around building Sinatra applications.
3. Eases the transition to Rails for Dev Bootcamp students

### Quickstart

1.  `bundle install`
2.  `shotgun config.ru`

As needed, create models & migrations with the `rake` tasks:

```
rake generate:migration  # Create an empty migration in db/migrate, e.g., rake generate:migration NAME=create_tasks
rake generate:model      # Create an empty model in app/models, e.g., rake generate:model NAME=User
```

### Contributing

We would love for you to help make the skeleton more awesome, There are three ways to contribute:

1. Ask for a bug fix or enhancement!
2. Submit a pull request for a bug fix or enhancement!
3. Code review an open pull request!

Be prepared to give and receive specific, actionable, and kind feedback!
