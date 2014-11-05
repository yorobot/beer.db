## {{ country.title }}   ++
   ({{ country.code }})  ++
   {: #{{ country.key }} }

{{ country.beers.count }} beers, ++
{{ country.breweries.count }} breweries ++
 ( ++
  __{{ country.breweries.where(brewpub:false).count }}__ - ++
  {{ country.breweries.where(prod_l:true).count }} l/ ++
  {{ country.breweries.where(prod_m:true).count }} m/ ++
  {{ country.breweries.where(prod_l:false,prod_m:false,brewpub:false).count }} s; ++
  __{{ country.breweries.where(brewpub:true).count }}__ brewpubs ++
 ) ++


 .. <!-- list beers w/o (missing) breweries -->
 .. <!-- todo/fix: change name to uncategorized_beers -->
{% beers_missing_breweries = country.beers.where( 'brewery_id is null' )
   if beers_missing_breweries.count > 0
 %}

### Uncategorized Beers _({{ beers_missing_breweries.count }})_{:.count}

FIX - FIX - FIX:

  {{ render_beers( beers_missing_breweries ) }}
{% end %}

  .. <!-- list breweries w/o (missing) region -->
  .. <!-- todo/fix: change name to uncategorized_breweries -->
{% breweries_missing_regions = country.breweries.where( 'region_id is null' )
   if breweries_missing_regions.count > 0
 %}


### Uncategorized _({{ breweries_missing_regions.count }})_{:.count}

FIX - FIX - FIX:

  {{ render_breweries( breweries_missing_regions ) }}
{% end %}


  .. <!-- list regions w/ breweries -->
{% country.regions.each do |region| %}

### {{ region.title_w_synonyms }}

{{ region.beers.count }} beers, ++
{{ region.breweries.count }} breweries ++
 ( ++
  __{{ region.breweries.where(brewpub:false).count }}__ - ++
  {{ region.breweries.where(prod_l:true).count }} l/ ++
  {{ region.breweries.where(prod_m:true).count }} m/ ++
  {{ region.breweries.where(prod_l:false,prod_m:false,brewpub:false).count }} s; ++
  __{{ region.breweries.where(brewpub:true).count }}__ brewpubs ++
 ) ++


.. <!-- list uncategorized breweries e.g. w/o (missing) city -->

{% uncategorized_breweries = region.breweries.where( 'city_id is null' )
   if uncategorized_breweries.count > 0
 %}

FIX - FIX - FIX:

.. <!-- fix: use count helper -->
##### Uncategorized _({{ uncategorized_breweries.count }})_{:.count}

  {{ render_breweries( uncategorized_breweries ) }}
{% end %}


{% end %} <!-- each region -->
