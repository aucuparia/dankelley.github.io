---
layout: post
title: Oce translations
tags: [R, oce]
category: R
year: 2014
month: 2
day: 23
summary: The method for adding additional languages to Oce graphics is described.
description: The method for adding additional languages to Oce graphics is described.
---

A new user wondered how to get Spanish labels on axes, and so I started on the process of localizing the code, using the [GNU gettext](http://www.gnu.org/software/gettext/) scheme.  Gettext being unfamiliar to me, I stumbled a bit at first, and decided to document the successful steps here.  Readers may wish to consult [a Dropbox page](https://www.dropbox.com/sh/301wmxm4ddnv68v/7G85OTScZq) on my progress towards the goal of translating the main Oce plots into common languages.  For now, I am focussing on Spanish, French, and Mandarin.

## Initial work cycle

### Step 1

Create a directory named ``oce/po/``.

### Step 2

The basic procedure it to change a code fragment like
{% highlight R linenos=table %}
ylab="Depth"
{% endhighlight %}
which is clearly not appropriate in all langauges, into
{% highlight R linenos=table %}
gettext("Depth", domain="R-oce")
{% endhighlight %}
which yields an entry in a translation table that can then be tailored for any desired language.  (The ``gettext()`` call should not really need to set the ``domain``, but I found it necessary for some items, and decided to include it everywhere.)

### Step 3

Enter the ``oce`` directory, launch R, and type as follows, to insert a file named ``R-oce.pot`` in the ``po`` directory.


{% highlight R linenos=table %}
tools::update_pkg_po(".")
{% endhighlight %}

This create entries like the following in the file ``po/R-oce.pot``:
{% highlight bash linenos=table %}
msgid "Depth"
msgstr ""
{% endhighlight %}
The first of these is a key, and the second will be a replacement string (discussed presently).


### Step 4

To start work on, say, a French translation table, type the following in the shell.

{% highlight bash linenos=table %}
cd oce/po
msginit --locale=R-fr --input R-oce.pot
{% endhighlight %}

This creates an English-French translation table in a file named ``po/R-fr.po``.  This must be done just once for each language to be translated.  The key is the ``fr`` part of the name, which is the [ISO-639](http://en.wikipedia.org/wiki/ISO_639) code for French.  

Once the file is created, look at it with a text editor and, if necessary, change the ``charset`` to ``UTF-8``, which can handle most languages.

Importantly, running ``msginit`` is only necessary at the first stage of translation.  As new entries are added, one must only follow the work cycle given below.

### Step 5

Edit ``po/R-fr.po`` as desired, inserting translations.  You will need a text editor that permits characters in a variety of languages; vim and emacs are ideal for this.

Simply change the ``msgstr`` item to the translated value, e.g. for French the ``R-fr.po`` file should contain
{% highlight bash linenos=table %}
msgid "Depth"
msgstr "Profondeur"
{% endhighlight %}
for this entry.


## Update work cycle

The work cycle is as follows.

1. Edit the R source code, replacing strings like ``FOO`` with ``gettext("FOO", "R-oce")``.

2. Launch R in the ``oce`` directory and invoke ``tools::update_pkg_po(".")`` to add an entry to the ``po/R-oce.pot`` file, with corresponding entries in ``po/R-fr.po`` and any other existing translation files.

3. Edit ``po/R-fr.po`` and any other translation files, changing the ``msgstr`` entry that corresponds to ``FOO``.

4. Run ``tools::update_pkg_po(".")`` again, to update all relevant files in the ``inst`` directory.

5. Build and test oce.

6. Repeat from step 1 as required for other words.

Since step 5 is slow, it helps to be watching your country win a gold medal in the Olympics hockey game, while you are doing such work.

## An example

{% highlight r linenos=table %}
library(oce)
data(ctd)
par(mfrow = c(1, 3))
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE = "es")
plotProfile(ctd, "T")
Sys.setenv(LANGUAGE = "fr")
plotProfile(ctd, "T")
{% endhighlight %}

produces the graph shown below (click to enlarge).

[![center]({{ site.url }}/assets/2014-02-21-oce-translations-thumbnail.png)]({{ site.url }}/assets/2014-02-21-oce-translations.png)

## Using translations

In most cases the system language will be set with system tools.  Still, ``Sys.setenv()`` can be handy for switching the language used in a plot (e.g. a French user may have the computer set up to work in French, but may prefer to graph data using English, for publication).  Commonly, ``Sys.setenv()`` will be done in the R startup file, or defined in the OS shell, e.g. below for a temporary use

{% highlight bash linenos=table %}
LANG=es_ES.UTF-8 R --no-save < spanish.R
{% endhighlight %}



## Helping me with the translation effort

At the moment, Oce works in English, with some support for Spanish and French, and just a few test words for Mandarin.  (For Mandarine, be sure to specify your PDF plot device as e.g. ``pdf(..., family="BG1")`` so that proper fonts will be loaded.)

If you would like Oce graphs to work in another language with which you have high familiarity, please contact me.  I will need you to write down a few relevant words in your language and send them to me via PDF or scanned hand-written document (MSword and OpenOffice formats cannot are not useful).  Minimally, the words should be the ones used on axes of the graphs you use, but it would help other users if you could translate the phrases listed below.  Also, translate ``E``, ``W``, ``N``, and ``S``, as used in longitude and latitude, as well as any other unit abbreviations that differ between English and your language.

{% highlight bash linenos=table %}
Absolute Salinity
Conservative Temperature
Depth
Distance
Elevation
Longitude
Latitude
Potential Temperature
Potential Density Anomaly
Practical Salinity
Pressure
Sea Level
Speed
Temperature
Velocity
{% endhighlight %}

For some languages (especially Asian ones) it is best to send me a UTF-8 file with the translated phrases that I can copy and paste into the source files.  For example, below is a screenshot showing a rough guess at Mandarin, which I found by using an onine translation engine.

![center]({{ site.url }}/assets/2012-02-21-translation-editor.png)
