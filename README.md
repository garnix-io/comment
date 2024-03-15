# `comment`

`comment` is a simple tool to add comments to process invocations.
For example you can run the following command in one shell:

```bash
comment this is a sleep command -- sleep 10
```

and then if -- within 10 seconds -- you run this command in another shell:

```bash
ps aux | grep sleep
```

the output of that will include something like:

```
shahn    1003826  0.0  0.0   3072  1920 pts/12   S+   15:12   0:00 comment this is a sleep command -- sleep 10
```
