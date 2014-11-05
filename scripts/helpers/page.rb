# encoding: utf-8

##########################
# page helpers


### todo: check why it is not working in PageTemplate ??

def quickfix_concat_lines( text )
  # lines ending with ++ will get newlines get removed
  # e.g.
  # >| hello1 ++
  # >1 hello2
  # becomes
  # >| hello1 hello2
  #
  
  #
  # FIX: for windows
  #  - needs to check for carriage return (/r)  !!!
  #  on unix - there's no carriage return (thus, w/o it fails if processing w/ /r)
  
  # note: do NOT use \s - will include \n (newline) ??

  text = text.gsub( /\r/, '' )  ## windows-compatible - remove all carriage returns!!!


  ## remove_blanks
  # remove lines only with ..
  text = text.gsub( /^[ \t]*\.{2}[ \t]*\n/, '' )

  ## text.gsub( /[ \t]+\+{2}[ \t]*\n[ \t]*/, ' ' ) # note: replace with single space
  ## todo \n[ \t]* why is it not working ??? match w/ optional spaces after newline???
  ##  create some unit tests to verify/assert !!!!
  ##  use ()? to make it optional?

  text = text.gsub( /[ \t]+\+{2}[ \t]*\n/, ' ' )
  text
end



def render_country( country, opts={} )
  tmpl = TextUtils::PageTemplate.read( 'templates/country.md' )
  quickfix_concat_lines( tmpl.render( binding ) )
end

def render_country_mini( country, opts={} )
  tmpl = TextUtils::PageTemplate.read( 'templates/country-mini.md' )
  quickfix_concat_lines( tmpl.render( binding ) )
end

def render_country_stats( country, opts={} )
  tmpl = TextUtils::PageTemplate.read( 'templates/country-stats.md' )
  quickfix_concat_lines( tmpl.render( binding ) )
end


def render_toc( opts={} )
  tmpl = File.read_utf8( 'templates/toc.md' )
  render_erb_template( tmpl, binding )
end

def render_whats_news_in_year( year, opts={} )
  tmpl = File.read_utf8( 'templates/whats-news-in-year.md' )
  render_erb_template( tmpl, binding )
end


def render_breweries_idx( opts={} )
  tmpl = TextUtils::PageTemplate.read( 'templates/breweries-idx.md' )
  quickfix_concat_lines( tmpl.render( binding ) )
end


def render_beers_idx( opts={} )
  tmpl = File.read_utf8( 'templates/beers-idx.md' )
  render_erb_template( tmpl, binding )
end

def render_brands_idx( opts={} )
  tmpl = File.read_utf8( 'templates/brands-idx.md' )
  render_erb_template( tmpl, binding )
end
