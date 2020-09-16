#!/usr/bin/perl
$latex         = 'platex -kanji=utf8 -halt-on-error %O %S';
$bibtex        = 'pbibtex %O %B';
$dvipdf        = 'dvipdfmx %O %S';
$pdf_mode      = 3; # use dvipdf
$pdf_previewer = 'evince %O %S';

