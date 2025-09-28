---
title: My Title
date: Created <span class="redoc" id="redoc-inlinecode-1">2024-12-14</span>
output: 
  redoc::redoc:
    keep_md: true
---

# Reversible R Markdown Document

This is an example Reversible R Markdown document. It will preserve code
elements for restoration in your final `.docx` file.

You can use things like inline <span class="redoc" id="redoc-htmlcomment-1"><!--- an HTML comment ---></span> comments.

You can use code chunks to generate output and they will be restored:

<div class="redoc" id="redoc-codechunk-1">

``` r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

</div>

# Inline text

<div class="redoc" id="redoc-codechunk-2">


</div>

You can include calculations inline like so: <span class="redoc" id="redoc-inlinecode-2">2</span> plus
<span class="redoc" id="redoc-inlinecode-3">3</span> equals <span class="redoc" id="redoc-inlinecode-4">5</span>. Even empty inline
chunks <span class="redoc" id="redoc-inlinecode-5"></span> will be stored and marked with hidden text in
the Word document.

# Chunks with plots

You can of course also embed plots, for example:

<div class="redoc" id="redoc-codechunk-3">

``` r
plot(pressure)
```

![](example_files/figure-docx/pressure-1.png)<!-- -->

</div>

What about a regular figure?

![A **figure**](https://www.r-project.org/logo/Rlogo.png)

<div class="redoc" id="redoc-yaml-1">
---
# Additional YAML blocks can be added and will be restored
hello: there
---

</div>


