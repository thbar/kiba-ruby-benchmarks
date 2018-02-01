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
