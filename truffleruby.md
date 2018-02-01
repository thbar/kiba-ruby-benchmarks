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