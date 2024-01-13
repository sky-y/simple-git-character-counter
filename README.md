# Simple Git Character Counter

**This is a forked project from <https://github.com/jmatsuzaki/git-character-counter> by jmatsuzaki.**

Git Character Counter. Calculates the number of characters or words added based on the results of Git Diff.

Since Git Diff usually only counts additional lines, you can use this script to count additional characters or words.

By measuring the number of characters added since a specific date or commit, you can use it to measure your daily writing and programming productivity.

- [Simple Git Character Counter](#simple-git-character-counter)
  - [Features](#features)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Comparison with working directory](#comparison-with-working-directory)
    - [Specifing range of comparison](#specifing-range-of-comparison)
    - [Other options](#other-options)
  - [Future works (TODO)](#future-works-todo)
  - [Difference between original and forked version](#difference-between-original-and-forked-version)
  - [Authors](#authors)
    - [Original Author](#original-author)

## Features

- The only environment required is bash and git
- Use the git diff command to count the number of characters added to the file (Binary files are excluded)
- Try to exclude blank lines, line feeds
- Support for specifying n previous commits, commit hash values, and dates (date expression or ISO date)
- Support for specifying the start and end points for measurement
- Supports word count instead of character count

## Requirements

The only environment required is bash and git.

The development environment is as follows:

- GNU bash, version 5.0.17(1)-release
- git version 2.25.1

## Installation

Download or clone this repository.

It only needs git-character-counter.sh to work.

## Usage

Just run "git-character-counter.sh" in a shell.

```bash
bash /foo/bar/git-character-counter.sh
```

Or add this path to `PATH` environment variable.

By default, it calculates the number of characters from the difference between the staged file and HEAD.

Note that it is a Staging area (Index), not a Working directory.

The reason for this is that you can choose the target of the calculation even from within the Working directory. And you can also target new files by targeting a stage.

So, run this shell script after staging the file for which you want to calculate the number of characters.

```bash
$ git add .
$ bash /foo/bar/git-character-counter.sh
1896
```

### Comparison with working directory

You can compare HEAD with working directory by:

```bash
$ git-character-counter.sh -u
```

You can also compare HEAD with staged file by force (same as the default):

```bash
$ git-character-counter.sh -s
```

### Specifing range of comparison

The -f (from) and -t (to) options can be used to specify the start and end points of the comparison.

The following command compares the latest commit (HEAD) with the one before it (HEAD^). In other words, it calculates the number of characters added by the latest commit.

```bash
# "-f 1" means HEAD^, "-t 0" means HEAD.

git-character-counter.sh -f 1 -t 0
```

If a number is specified, it indicates the distance from HEAD. 0 is HEAD itself.

```bash
# "-f 3" means HEAD^^^, "-t 0" means HEAD.

git-character-counter.sh -f 3 -t 0
```

In addition to numbers, the -f and -t options can be the commit hash and date.

Hash can be a 40-digit full hash or a 7-digit abbreviated hash.

```bash
# All of the following commands will have the same result.

git-character-counter.sh -f 48b5460a426cf2beffd6d71f089d9c3278b4f705 -t 196ff5bdabaf10afdeb40f7623e0cc09eea1d7a5
git-character-counter.sh -f 48b5460 -t 196ff5b
git-character-counter.sh -f 48b5460a426cf2beffd6d71f089d9c3278b4f705 -t 196ff5b
```

The date can be date expression or ISO date.

```bash
# The following is an example of specifying a date expression.
# The following command will give you the number of characters added yesterday (If it contains whitespace, enclose it in ").

git-character-counter.sh -f "2 days ago" -t yesterday

# The following command will give you the number of characters added today (If -t is omitted, staged files will be targeted).

git-character-counter.sh -f yesterday

# In the following example, we get the number of characters added from yesterday to the latest commit (Staged files are not included).

git-character-counter.sh -f yesterday -t 0

# ISO date can be used to specify a specific date.

git-character-counter.sh -f 2022-02-05 -t 2022-02-06

# With ISO date, you can also specify the time (In this case, enclose it in ").

git-character-counter.sh -f "2022-02-06 0:00" -t "2022-02-06 23:59"
```

However, since date is an ambiguous concept in Git, we recommend specifying hash to get reliable results.

### Other options

-w option can be used to calculate the number of words instead of the number of characters. Note, however, that languages such as Japanese will not calculate the word count correctly.

```bash
git-character-counter.sh -w
```

## Future works (TODO)

See <https://github.com/jmatsuzaki/git-character-counter>

Note that this is a forked project that has no future work.

## Difference between original and forked version

This forked version:

- doesn't show friendly output; shows only word count instead
- doesn't remove frontmatter
- can specify `-u` and `-s` options to the target: working tree or staged files

## Authors

Yuki Fujiwara (@sky-y)

### Original Author

- [jMatsuzaki](https://jmatsuzaki.com/)
- [jMatsuzaki Inc.](https://jmatsuzaki.com/company)
- [@jmatsuzaki](https://twitter.com/jmatsuzaki)

