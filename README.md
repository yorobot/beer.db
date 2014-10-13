# build

Build scripts for beer.db, etc.


## Usage

Use `rake -T`  to list all available tasks. Example:

~~~
$ rake -T
~~~

will print something like:

~~~
rake about     # print versions of gems
rake book      # build book (draft version) - The Free World Beer Book
rake build     # build beer.db from scratch (default)
rake stats     # print stats for beer.db tables/records
~~~


To get started use the following folder structure and
clone some datasets with git. Example:

~~~
openmundi/               #  -> create folder (e.g. mkdir openmundi)
  world.db               #  -> git clone (see github.com/openmundi)
  austria.db             #  -> git clone (see github.com/openmundi)
openbeer/                #  -> create folder
  build                  #  -> git clone
  at-austria             #     ..
  de-deutschland         #     ..
~~~

Start your build (e.g. `rake build`) inside the `openbeer/build` folder.

Note: You can see (and change) all folder references in the [`settings.rb`](https://github.com/openbeer/build/blob/master/settings.rb) script.


## More Examples

Build the database for breweries, brewpubs and beers in Austria (from scratch):

~~~
rake build DATA=at
~~~

Update the database for breweries, brewpubs and beers in Austria:

~~~
rake update DATA=at
~~~

And so on and so forth.


## License

The build scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[Open Beer & Brewery Database Forum/Mailing List](http://groups.google.com/group/beerdb).
Thanks!
