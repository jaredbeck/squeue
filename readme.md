squeue
======

A simple RESTful FIFO queue on sinatra on rack.

```ruby
$ heroku create
$ git push heroku master
$ curl http://stormy-beyond-8212.herokuapp.com/q # 404
empty
$ curl -d derp http://stormy-beyond-8212.herokuapp.com/q # 201
$ curl http://stormy-beyond-8212.herokuapp.com/q # 200
derp
$ curl http://stormy-beyond-8212.herokuapp.com/q # 409
locked
$ curl -X delete http://stormy-beyond-8212.herokuapp.com/q # 204
$ curl http://stormy-beyond-8212.herokuapp.com/q # 404
empty
$ heroku apps:destroy stormy-beyond-8212
```

