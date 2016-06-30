![Screenshot of Makefile](https://cdn.pbrd.co/images/1C4FPlj3.png)

# Makefile for the Front End

I've used this Makefile for a fast development environment for a side-project 
that I no longer continue.

You can clone this repository to kickstart a frontend project. Required folder 
structure is set up for Makefile to work.

#### TL;DR

 - Use [static, non-preprocessed CSS](https://css-tricks.com/dont-use-css-preprocessors/) with [livereload](https://github.com/napcs/node-livereload) to give lightning-fast 
 prototyping abilities.

 - Use [watchify](https://github.com/substack/watchify) + [babelify](https://github.com/babel/babelify) to compile JSX and enable ES2015. Also auto-refresh 
 the browser.

 - Minify HTML ([html-minifier](https://github.com/kangax/html-minifier)), CSS ([cssnano](https://github.com/ben-eb/cssnano)), JS ([uglifyjs](https://github.com/mishoo/UglifyJS2)) for production.

 - Use PostCSS plugins ([import](https://github.com/postcss/postcss-import), [autoprefixer](https://github.com/postcss/autoprefixer)) for production CSS.


## Why Make?

I'm using Make to manage ops-side of my front-end projects because it's simple.
In Gulp, Grunt or Webpack or any other tool, you have to comprehend the complexity
of programmatic usage and learn how some 3rd party abstractions work.

When, instead, Make is used for the same tasks, it's much easier for anyone to
contribute, fix or make any kind of change on the build script (at least for me). 
It's not asynchronous, it doesn't give you abstractions to "make your job easier". 
It's flat. You read a Makefile in sequential order, with no indirection.

## Setup

You need `Node` and `npm` installed on your machine which is capable of running 
Makefiles (i.e: not Windows as far as I know).

```
# Clone the repository
git clone git@github.com:scriptype/Makefile-for-the-Front-End.git

# Go to project directory
cd Makefile-for-the-Front-End

# Install dependencies
npm i
```

Besides modules used in Makefile, `react` and `react-dom` for JS and 
`express` for dev-server will also be installed. They are not mandatory.

## Run

#### Development

```sh
make
```

When finished, head over to `localhost:8080`

#### Production

```sh
make release
```

When finished, head over to `localhost:8080`

## Notes

  - It's far from being perfect (and it's not intended to be).

  - `Express` dependency is for `server.js`. You can remove it and handle 
  dev-server however you like.

  - Handlebars is used in `index.html` to dynamically manipulate the path of JS 
  and CSS files according to environment. It also calls livereload script in dev mode.

  - No CSS pre-processor was used. CSS files are completely static and source files 
  are directly used in dev mode. You get an experience similar to prototyping in 
  browser thanks to livereload.

  - When releasing the project:

    - CSS will be autoprefixed and `@imports` will be concatenated into a single file.

    - JS modules will be babelified with `react` and `es2015` presets.

    - HTML, JS and CSS outputs will be minified.

## Contribution

Please don't hesitate to open issues and making pull requests. When doing that, 
consider that this boilerplate is aimed to have minimum complexity. e.g: Implementing 
redux is out of scope in this project.

## Licence
```
MIT License

Copyright (c) 2016 Mustafa Enes Ertarhanacı

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
