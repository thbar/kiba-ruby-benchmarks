### Attempt to get this running on TruffleRuby

* https://github.com/oracle/truffleruby#getting-started) encourages me to try out TruffleRuby via GraalVM.
* http://www.oracle.com/technetwork/oracle-labs/program-languages/ let me download the Mac tgz after login in with Oracle account.

Then I can unpack:

```
cd graalvm
tar -zxvf graalvm-0.30.2-macosx-amd64-jdk8.tar.gz
```

This way I have:

```
graalvm/graalvm-0.30.2
```

and I can run Ruby with:

```
graalvm/graalvm-0.30.2/Contents/Home/bin/ruby -v
truffleruby 0.30.2, like ruby 2.3.5 <Java HotSpot(TM) 64-Bit Server VM 1.8.0_151-b12 with Graal> [darwin-x86_64]
```

To go further, I wanted to run the Kiba test suite, here is what I had to do:

* Figure out where `gem` command is located (I thought it wouldn't exist initially)
* Tweak my path like this:

```
export PATH=~/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/bin:$PATH
```

* Tell `rvm` not to try to do anything (or I'd get warnings)

```
rvm use system
```

* Figure out weither or not `bundler` is supported (I didn't see a bundled command)
* Realising that `gem install minitest-focus` works
* I was then able to run:

```
$ ruby -v
truffleruby 0.30.2, like ruby 2.3.5 <Java HotSpot(TM) 64-Bit Server VM 1.8.0_151-b12 with Graal> [darwin-x86_64]
$ gem install minitest-focus
# this worked
$ ruby test/test_parser.rb
# this did not (cannot load such file -- kiba)
$ ruby test/test*.rb
```

Then I realized that maybe installing `bundler` as a gem would work:

```
$ gem install bundler
```

It worked fast enough, but then it started installing the documentation, which took ages & made my CPU go to 400%:

```
Parsing documentation for bundler-1.16.1
Installing ri documentation for bundler-1.16.1
Done installing documentation for bundler after 115 seconds
```

(Yup, 115 seconds).

I added a `~/.gemrc` file with this:

```
gem: --no-document
```

in order to try to avoid that.

Then I tried to install the Kiba development dependencies, but got this error:

```
$ bundle install
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/patches/bundler/bundler.rb:5:in `<top (required)>': unsupported bundler version please use 1.14.x (RuntimeError)
```

I checked the rubygems page to verify what's the latest 1.14.x here https://rubygems.org/gems/bundler/versions then ran:

```
gem uninstall bundler
gem install bundler -v 1.14.6
```

I finally ran:

```
bundle install
```

which took my CPU back to 360%, and showed a few warnings, but ultimately succeeded:

```

19:17 $ bundle install
warning: already initialized constant Bundler::Dependency::PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:12: warning: previous definition of PLATFORM_MAP was here
warning: already initialized constant Bundler::Dependency::REVERSE_PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:70: warning: previous definition of REVERSE_PLATFORM_MAP was here
Fetching gem metadata from https://rubygems.org/.........................
Fetching version metadata from https://rubygems.org/..
Resolving dependencies.......
Installing rake 12.3.0
Installing awesome_print 1.8.0
Using kiba 2.0.0 from source at `.`
Installing minitest 5.11.3
Using bundler 1.14.6
Using minitest-focus 1.1.2
Bundle complete! 5 Gemfile dependencies, 6 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
```

At this point I was able to run Kiba's test suite:

```
19:20 $ bundle exec rake
warning: already initialized constant Bundler::Dependency::PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:12: warning: previous definition of PLATFORM_MAP was here
warning: already initialized constant Bundler::Dependency::REVERSE_PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:70: warning: previous definition of REVERSE_PLATFORM_MAP was here
[ruby] WARN A nonstandard GEM_HOME is set /Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0
warning: already initialized constant Bundler::Dependency::PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:12: warning: previous definition of PLATFORM_MAP was here
warning: already initialized constant Bundler::Dependency::REVERSE_PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:70: warning: previous definition of REVERSE_PLATFORM_MAP was here
Run options: --seed 4569

# Running:

......................................

Fabulous run in 2.025488s, 18.7609 runs/s, 30.6099 assertions/s.

38 runs, 62 assertions, 0 failures, 0 errors, 0 skips
```

Since Kiba's tests were passing, I went further to the benchmarks:

```
cd ~/git/kiba-ruby-benchmarks
bundle install
brew install axel
bundle exec kiba setup.etl
```

Then I wanted to run the benchmark, but got:

```
19:25 $ bundle exec kiba csv_processing.etl
warning: already initialized constant Bundler::Dependency::PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:12: warning: previous definition of PLATFORM_MAP was here
warning: already initialized constant Bundler::Dependency::REVERSE_PLATFORM_MAP
/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/gems/bundler-1.14.6/lib/bundler/dependency.rb:70: warning: previous definition of REVERSE_PLATFORM_MAP was here
bundler: failed to load command: kiba (/Users/thbar/graalvm/graalvm-0.30.2/Contents/Home/jre/languages/ruby/lib/ruby/gems/2.3.0/bin/kiba)
LoadError: cannot load such file -- csv_processing.etl/etl/csv_source
  csv_processing.etl:2:in `require_relative'
```

I believe there is a subtle difference in the way require paths are handled, at least when using `instance_eval` like Kiba does.
