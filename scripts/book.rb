# encoding: utf-8


# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'
require_relative 'helpers/misc'
require_relative 'helpers/beer'
require_relative 'helpers/brewery'
require_relative 'helpers/city'
require_relative 'helpers/page'


require_relative 'utils'



puts '[book] Welcome'
puts "[book]   Dir.pwd: #{Dir.pwd}"
puts "[book]   PAGES_DIR: #{PAGES_DIR}"


### model shortcuts

require_relative 'models'


#####
# todo/fix: use constant to set  ./_pages   - output (root) folder for generated pages
# todo/fix: use constant to set layout  e.g. book



######
# fix/todo: add to textutils
#  allow passing in of root folder - how? new arg?
#    or use self.create_with_path or similiar ???
#  or use PageV2   and alias w/ Page = TextUtils::PageV2  ??


class Page
  def self.create( name, opts={} )
    path = "#{PAGES_DIR}/#{name}.md"
    puts "[book] create page #{name} (#{path})"

    TextUtils::Page.create( path, opts ) do |page|
      yield( page )
    end
  end

  def self.update( name, opts={} )
    path = "#{PAGES_DIR}/#{name}.md"
    puts "[book] update page #{name} (#{path})"

    TextUtils::Page.update( path, opts ) do |page|
      yield( page )
    end
  end
end # class Page


def build_book_for_country( country_code, opts={} )

  country = Country.find_by_key!( country_code )

### generate breweries index

  Page.create( "#{country.key}-breweries", frontmatter: {
                            layout: 'book',
                            title: 'Breweries Index',
                            permalink: "/#{country.key}-breweries.html" }) do |page|
    page.write render_breweries_idx( opts )
  end

  ### generate pages for countries


  beers_count     = country.beers.count
  breweries_count = country.breweries.count
  
  puts "build country page #{country.key}..."

  path = country_to_path( country )
  puts "path=#{path}"
  Page.create( path, frontmatter: {
                       layout:    'book',
                       title:     "#{country.title} (#{country.code})",
                       permalink: "/#{country.key}.html" }) do |page|
    page.write render_country( country, opts )
  end
end




def build_book( opts={} )


### generate what's news in 2014

years = [2014,2013,2012,2011,2010]
years.each do |year|
  Page.create( "#{year}", frontmatter: {
                            layout: 'book',
                            title:  "What's News in #{year}?",
                            permalink: "/#{year}.html" }) do |page|
    page.write render_whats_news_in_year( year, opts )
  end
end


### generate breweries index

Page.create( 'breweries', frontmatter: {
                            layout: 'book',
                            title: 'Breweries Index',
                            permalink: '/breweries.html' }) do |page|
  page.write render_breweries_idx( opts )
end


### generate beers index

Page.create( 'beers', frontmatter: {
                         layout: 'book',
                         title: 'Beers Index',
                         permalink: '/beers.html' }) do |page|
  page.write render_beers_idx( opts )
end


### generate brands index

Page.create( 'brands', frontmatter: {
                         layout: 'book',
                         title: 'Brands Index',
                         permalink: '/brands.html' }) do |page|
  page.write render_brands_idx( opts )
end



### generate table of contents (toc)

Page.create( 'index', frontmatter:  {
                          layout: 'book',
                          title: 'Contents',
                          permalink: '/index.html' }) do |page|
  page.write render_toc( opts )
end



### generate pages for countries

country_count=0
# Country.where( "key in ('at','mx','hr', 'de', 'be', 'nl', 'cz')" ).each do |country|
Country.all.each do |country|
  beers_count     = country.beers.count
  breweries_count = country.breweries.count
  next if beers_count == 0 && breweries_count == 0
  
  country_count += 1
  puts "build country page #{country.key}..."

  path = country_to_path( country )
  puts "path=#{path}"
  Page.create( path, frontmatter: {
                       layout:    'book',
                       title:     "#{country.title} (#{country.code})",
                       permalink: "/#{country.key}.html" }) do |page|
    page.write render_country( country, opts )
  end

  ## break if country_count == 3    # note: for testing only build three country pages
end

end # method build_book



##########################################
# 2) generate all-in-one-page version


####
# fix: remove!!!!
#   use all-in-one-page book order in generation above
#    and delete build_book_all_in_one 

def build_book_all_in_one_old_code_remove

book_text = <<EOS
---
layout: book
title: Contents
permalink: /book.html
---

EOS

book_text += render_toc( inline: true )


### generate pages for countries
# note: use same order as table of contents

country_count=0

Continent.all.each do |continent|
  continent.countries.order(:name).each do |country|

    beers_count     = country.beers.count
    breweries_count = country.breweries.count
    next if beers_count == 0 && breweries_count == 0
    
    country_count += 1
    puts "build country page #{country.key}..."
    country_text = render_country( country )

    book_text += <<EOS

---------------------------------------

EOS

    book_text += country_text
  end
end


File.open( '_pages/book.md', 'w+') do |file|
  file.write book_text
end

end # method build_book_all_in_one
