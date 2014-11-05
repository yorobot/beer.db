## {{ country.title }}   ++
   ({{ country.code }})  ++
   -                     ++
   {{ country.breweries.count }} Breweries
   {: #{{ country.key }} }

 .. <!-- add intra-page links for regions here -->
 <!-- change to navbar_regions_for_country ?? -->
 {{ regions_navbar_for_country( country ) }}

  .. <!-- list breweries w/o (missing) region -->
  .. <!-- todo/fix: change name to uncategorized_breweries -->
{% breweries_missing_regions = country.breweries.where( 'region_id is null' )
   if breweries_missing_regions.count > 0
 %}

### Uncategorized _({{ breweries_missing_regions.count }})_{:.count}

  {{ render_breweries_mini( breweries_missing_regions ) }}
{% end %}


  .. <!-- list regions w/ breweries -->
{% country.regions.each do |region| %}

### {{ region.title_w_synonyms }}  ++
    _({{ region.breweries.count }})_{:.count}
{: #{{ country.key }}-{{ region.key }} }

 .. <!-- add intra-page cities for regions links here -->
 <!-- change to navbar_cities_for_region( region ) ??? -->
 {{ cities_navbar_for_region( region ) }}


 {{ render_breweries_mini( region.breweries ) }}


.. <!-- list uncategorized breweries e.g. w/o (missing) city -->
{% uncategorized_breweries = region.breweries.where( 'city_id is null' )
   if uncategorized_breweries.count > 0
 %}

.. <!-- fix: use count helper -->
##### Uncategorized _({{ uncategorized_breweries.count }})_{:.count}

  {{ render_breweries_mini( uncategorized_breweries ) }}
{% end %}


{% end %} <!-- each region -->
