---
layout: post
title: Valentines-day full moon
tags: [R, astronomy, romance]
category: R
year: 2014
month: 2
day: 13
summary: There will be a full moon on Valentine's Day this year.  How common is that?
description: There will be a full moon on Valentine's Day this year.  How common is that?
---

# Introduction

A wise person told me that it will be a full moon on the upcoming Valentine's Day, but that it will be a long time until another one.  I decided to check this with astronomical calculation.

# Procedure

The Oce package has a function called ``moonAngle()`` that returns, among other things, the illuminated fraction of the moon visible at any given time.  This can be used to test for a full moon on Valentine's day.

The first step is to construct the times of Valentine's days, starting with the one this year.  Then the illuminated fraction can be calculated (here, for Halifax, the lover's capital of Canada), and that fraction can be plotted for each of the next fifty years, with red dots for the romantic times, and blue ones for the so-sad ones.


{% highlight r linenos=table %}
times <- seq(as.POSIXct("2014-02-14", tz="UTC"), length.out=50, by="year")
library(oce)
fraction <- moonAngle(times, lon=-63, lat=43)$illuminatedFraction
full <- fraction > 0.99
plot(times, fraction, xlab="Year", ylab="Moon Illuminated Fraction",
     col=ifelse(full, "red", "blue"), pch=16, cex=2)
{% endhighlight %}

![center](http://dankelley.github.io/figs/2014-02-13-valentine-moon/valentines-1.png) 

Here, red has been used to indicate years with full moon on Valentine's Day, and sad blue otherwise.

# Results

It will be a long time until the next full moon on Valentine's Day:

{% highlight r linenos=table %}
times[full]
{% endhighlight %}



{% highlight text %}
## [1] "2014-02-14 UTC" "2033-02-14 UTC" "2044-02-14 UTC" "2052-02-14 UTC"
## [5] "2063-02-14 UTC"
{% endhighlight %}

# Conclusions

* Buy candy now.

# Resources

* R source code used here: [2014-02-13-valentine-moon.R]({{ site.url }}/assets/2014-02-13-valentine-moon.R)
* Jekyll source code for this blog entry: [2014-02-13-valentine-moon.Rmd](https://raw.github.com/dankelley/dankelley.github.io/master/assets/2014-02-13-valentine-moon.Rmd)
