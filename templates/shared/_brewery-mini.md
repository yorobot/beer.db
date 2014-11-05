__{{ brewery_title( brewery ) }}__ ++
{% if brewery.founded.present? %} ++
  - {{ brewery.founded }} ++
{% end %} ++
{{ brewery_tags( brewery ) }} ++
..
{% if brewery.address.present? %} ++
  {{ brewery.address }}  ++
{% end %}   ++
.. <!-- check if activerecord supports web? for present? check - if not add it to model -->
.. <!-- fix: use web symbol - no need to use br/break - why? why not?? -->
{% if brewery.web.present? %}  ++
  {{ link_to brewery.web, "http://#{brewery.web}" }}  ++
.. <!-- fix: use link_to_brewery_website -->
{% end %} ++
<br>
