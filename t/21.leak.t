use strict;
use warnings;
use constant HAS_LEAKTRACE => eval{ require Test::LeakTrace };
use Test::More HAS_LEAKTRACE ? (tests => 1) : (skip_all => 'require Test::LeakTrace');
use Test::LeakTrace;
use Text::Creolize::Xs;

my $wiki_source = do{local $/ = undef; <DATA> };
{
    Text::Creolize::Xs->new->convert($wiki_source);
}

leaks_cmp_ok{
    Text::Creolize::Xs->new->convert($wiki_source);
} '<', 1;

__END__
= Top-level heading (1 1)
== This a test for creole 0.1 (1 2)
=== This is a Subheading (1 3)
==== Subsub (1 4)
===== Subsubsub (1 5)

The ending equal signs should not be displayed:

= Top-level heading (2 1) =
== This a test for creole 0.1 (2 2) ==
=== This is a Subheading (2 3) ===
==== Subsub (2 4) ====
===== Subsubsub (2 5) =====


You can make things **bold** or //italic// or **//both//** or //**both**//.

Character formatting extends across line breaks: **bold,
this is still bold. This line deliberately does not end in star-star.

Not bold. Character formatting does not cross paragraph boundaries.

You can use [[internal links]] or [[http://www.wikicreole.org|external links]],
give the link a [[internal links|different]] name.

Here's another sentence: This wisdom is taken from [[Ward Cunningham's]]
[[http://www.c2.com/doc/wikisym/WikiSym2006.pdf|Presentation at the Wikisym 06]].

Here's a external link without a description: [[http://www.wikicreole.org]]

Be careful that italic links are rendered properly:  //[[http://my.book.example/|My Book Title]]// 

Free links without braces should be rendered as well, like http://www.wikicreole.org/ and http://www.wikicreole.org/users/~example. 

Creole1.0 specifies that http://bar and ftp://bar should not render italic,
something like foo://bar should render as italic.

You can use this to draw a line to separate the page:
----

You can use lists, start it at the first column for now, please...

unnumbered lists are like
* item a
* item b
* **bold item c**

blank space is also permitted before lists like:
  *   item a
 * item b
* item c
 ** item c.a

or you can number them
# [[item 1]]
# item 2
# // italic item 3 //
    ## item 3.1
  ## item 3.2

up to five levels
* 1
** 2
*** 3
**** 4
***** 5

* You can have
multiline list items
* this is a second multiline
list item

You can use nowiki syntax if you would like do stuff like this:

{{{
Guitar Chord C:

||---|---|---|
||-0-|---|---|
||---|---|---|
||---|-0-|---|
||---|---|-0-|
||---|---|---|
}}}

You can also use it inline nowiki {{{ in a sentence }}} like this.

= Escapes =
Normal Link: http://wikicreole.org/ - now same link, but escaped: ~http://wikicreole.org/ 

Normal asterisks: ~**not bold~**

a tilde alone: ~

a tilde escapes itself: ~~xxx

=== Creole 0.2 ===

This should be a flower with the ALT text "this is a flower" if your wiki supports ALT text on images:

{{Red-Flower.jpg|here is a red flower}}

=== Creole 0.4 ===

Tables are done like this:

|=header col1|=header col2| 
|col1|col2| 
|you         |can         | 
|also        |align\\ it. | 

You can format an address by simply forcing linebreaks:

My contact dates:\\
Pone: xyz\\
Fax: +45\\
Mobile: abc

=== Creole 0.5 ===

|= Header title               |= Another header title     |
| {{{ //not italic text// }}} | {{{ **not bold text** }}} |
| //italic text//             | **  bold text **          |

=== Creole 1.0 ===

If interwiki links are setup in your wiki, this links to the WikiCreole page about Creole 1.0 test cases: [[WikiCreole:Creole1.0TestCases]].

