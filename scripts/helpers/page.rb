# encoding: utf-8

##########################
# page helpers


def render_country( country, opts={} )
  tmpl       = File.read_utf8( 'templates/country.md' )
  render_erb_template( tmpl, binding )
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
  tmpl = File.read_utf8( 'templates/breweries-idx.md' )
  render_erb_template( tmpl, binding )
end

def render_beers_idx( opts={} )
  tmpl = File.read_utf8( 'templates/beers-idx.md' )
  render_erb_template( tmpl, binding )
end

def render_brands_idx( opts={} )
  tmpl = File.read_utf8( 'templates/brands-idx.md' )
  render_erb_template( tmpl, binding )
end
