# ROE

The Relational Object Expressions library, or ROE.

Forked from [PharoExtras / ROE](http://smalltalkhub.com/#!/~PharoExtras/ROE)

## Changes

- Pharo 7 support
- Refactored code
- PostgreSQL connection now assumes [P3](https://github.com/svenvc/P3)
- SQLite3 connection now assumes [Pharo-SQLite3](https://github.com/pharo-rdbms/Pharo-SQLite3)
- Added [Tarantool](https://www.tarantool.io) adapter (via [Tarantalk](https://github.com/mumez/Tarantalk))

## Installation

```
Metacello new
  baseline: 'Roe';
  repository: 'github://mumez/ROE/src';
  load
```
## Testing

Before unit testing, you should set database URLs according to your environment.

```
RATestPostgresSemantics urlString: 'psql://postgres:passwd@localhost:5432/postgres'.
RATestTarantoolSemantics uriString: 'taran:talk@localhost:3301'.
```

For SQLite3, please put the sqlite3 shared library (libsqlite3.so, dylib, dll or whatever}) on your image directory.

Note that RATestSemantics is an abstract class and should not be run.

There are also convenience method #runTests.
```
RATestPostgresSemantics runTests.
RATestSQLiteSemantics runTests.
RATestTarantoolSemantics runTests.
```
