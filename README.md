# Colours

I knocked this one up as a proof of concept and thought I'd share it. Simply feed it an image URL or just hit the root and it'll return a random Instragram image that's been tagged 'sunset'.

## Installation

Firstly, make sure you've [installed Ruby](http://www.ruby-lang.org/en/). Also, install the [Heroku Toolbelt](https://toolbelt.heroku.com/) as it includes [Foreman](https://github.com/ddollar/foreman) for running Procfile-based applications.

Then in terminal, clone me:

```
$ git clone https://github.com/kripy/colours colours
$ cd colours
$ bundle
$ foreman start
```

Open up a browser at ```http://localhost:5000/```. Then try something like ```http://localhost:5000/?img=http://distilleryimage5.ak.instagram.com/f87f895cf3bf11e29b6e22000aeb1b47_7.jpg```.

## Deployment
As with most of my work, it's Heroku ready:

```
$ cd colours
$ git init
$ git add .
$ git commit -m "init"
$ heroku create
$ git push heroku master
$ heroku open
```
## MIT LICENSE

Copyright (c) 2013 Arturo Escartin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.