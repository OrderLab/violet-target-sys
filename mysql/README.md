# Violet-Instrumented MySQL

## Compile S2E-Aware MySQL

To compile the Violet-instrumented MySQL to execute under S2E, you make sure the 
`S2EDIR` environment variable is set to the root path of S2E.

```bash
$ source ~/violet/workspace/s2e_activate
$ echo $S2EDIR
$ ./compile.sh
$ cd build
$ make install
```

Now the executable in `dist/bin/mysqld` is amenable to S2E analysis.

## Compile Native MySQL Compilation

It is also feasible to compile the Violet-instrumented MySQL to execute natively.
For that, you must build it in the shell without S2E env (unset the `S2EDIR`). 

```bash
$ unset S2EDIR
$ unset VIO_SYM_CONFIGS
$ ./compile.sh normal
$ cd normal/build
$ make install
```

Now the executable in `normal/dist/bin/mysqld` can be executed natively. But we 
must first initialize the database. The `init_db.sh` is for that purpose:

```bash
# Assume we are in normal/build
$ cd ..
$ ../init_db.sh
```

Afterwards you can start MySQL natively as usual:

```bash
$ cd dist
$ ./bin/mysqld --defaults-file=my.cnf --one-thread &
```
