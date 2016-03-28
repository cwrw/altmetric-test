# Altmetric Programming Exercise

There are three data files:

* journals.csv: a list of journal titles and ISSNs;
* articles.csv: a list of article DOIs [0], titles and ISSNs;
* authors.json: a list of author names and their article DOIs.

This ruby program combines these data files and outputs a single text file in one of two different formats:

* CSV with columns of DOI, Article title, Author name, Journal title and
  Journal ISSN, e.g.

      10.1234/altmetric0,Small Wooden Chair,Amari Lubowitz,"Shanahan, Green and Ziemann",1337-8688

* JSON as an array of objects with fields for DOI, title, author, journal and
  ISSN, e.g.

    {
        "doi": "10.1234/altmetric0",
        "title": "Small Wooden Chair",
        "author": "Amari Lubowitz",
        "journal": "Shanahan, Green and Ziemann",
        "issn": "1337-8688"
    }

ISSNs are always formatted as two groups of four digits
separated by a hyphen, e.g. 1234-5678, but might be missing the hyphen in the
source data.

## Usage

  $ ruby ``bin/combine --format json journals.csv articles.csv authors.json > full_articles.json``

  $ ruby ``bin/combine --format csv journals.csv articles.csv authors.json > full_articles.csv``

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake` to run the tests.


