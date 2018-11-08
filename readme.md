WIP.

```
./benchmarker --install
./benchmarker --setup
./benchmarker --run
```

### Latest results

* 2.6.0preview3 seems to be slower than 2.6.0preview2
* the JIT version is slightly slower

```
$ ./benchmarker --run-all
I, [2018-11-08T19:35:41.451682 #79311]  INFO -- : Running with ruby 2.5.3p105
I, [2018-11-08T19:35:41.451771 #79311]  INFO -- : Opening data/extract-1000k.csv
I, [2018-11-08T19:39:17.963685 #79311]  INFO -- : Processing done (took 216.51 seconds) - 999901 rows processed
4068053997 51935714 data/output.csv
I, [2018-11-08T19:39:18.699593 #79366]  INFO -- : Running with ruby 2.6.0preview2
I, [2018-11-08T19:39:18.699685 #79366]  INFO -- : Opening data/extract-1000k.csv
I, [2018-11-08T19:42:27.177117 #79366]  INFO -- : Processing done (took 188.48 seconds) - 999901 rows processed
4068053997 51935714 data/output.csv
I, [2018-11-08T19:42:27.616002 #79404]  INFO -- : Running with ruby 2.6.0preview3
I, [2018-11-08T19:42:27.616073 #79404]  INFO -- : Opening data/extract-1000k.csv
I, [2018-11-08T19:45:50.427047 #79404]  INFO -- : Processing done (took 202.81 seconds) - 999901 rows processed
4068053997 51935714 data/output.csv
JIT enabled now!!!
I, [2018-11-08T19:45:51.257123 #79429]  INFO -- : Running with ruby 2.6.0preview3
I, [2018-11-08T19:45:51.257212 #79429]  INFO -- : Opening data/extract-1000k.csv
I, [2018-11-08T19:49:10.444202 #79429]  INFO -- : Processing done (took 199.19 seconds) - 999901 rows processed
4068053997 51935714 data/output.csv
```

For the record:

```
I, [2018-11-08T19:56:31.742733 #5653]  INFO -- : Running with jruby 9.2.1.0
I, [2018-11-08T19:56:31.749452 #5653]  INFO -- : Opening data/extract-1000k.csv
I, [2018-11-08T19:59:27.835856 #5653]  INFO -- : Processing done (took 176.09 seconds) - 999901 rows processed
4068053997 51935714 data/output.csv
```

And TruffleRuby 1.0.0-rc9 fails with:

```
/Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1893:in `block (2 levels) in shift': Missing or stray quote in line 24473 (CSV::MalformedCSVError)
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1868:in `each'
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1868:in `block in shift'
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1828:in `loop'
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1828:in `shift'
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1770:in `each'
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1148:in `block in foreach'
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1299:in `open'
	from /Users/thbar/.rvm/rubies/truffleruby-1.0.0-rc9/lib/mri/csv.rb:1147:in `foreach'
	from /Users/thbar/git/kiba-ruby-benchmarks/etl/csv_source.rb:14:in `each'
```

### Results (previous benches with 10k rows)

```
I, [2017-12-28T23:54:36.848328 #8909]  INFO -- : Running with ruby 2.0.0
I, [2017-12-28T23:54:43.284895 #8909]  INFO -- : Processing done (took 6.44 seconds)

I, [2017-12-28T23:54:43.776679 #8950]  INFO -- : Running with ruby 2.1.10
I, [2017-12-28T23:54:49.424397 #8950]  INFO -- : Processing done (took 5.65 seconds)

I, [2017-12-28T23:54:49.938825 #8991]  INFO -- : Running with ruby 2.2.9
I, [2017-12-28T23:54:54.804360 #8991]  INFO -- : Processing done (took 4.87 seconds)

I, [2017-12-28T23:54:55.501460 #9032]  INFO -- : Running with ruby 2.3.5
I, [2017-12-28T23:55:00.100900 #9032]  INFO -- : Processing done (took 4.6 seconds)

I, [2017-12-28T23:55:00.767558 #9074]  INFO -- : Running with ruby 2.4.2
I, [2017-12-28T23:55:05.020349 #9074]  INFO -- : Processing done (took 4.25 seconds)

I, [2017-12-28T23:55:05.617250 #9115]  INFO -- : Running with ruby 2.5.0
I, [2017-12-28T23:55:09.087082 #9115]  INFO -- : Processing done (took 3.47 seconds)
```
