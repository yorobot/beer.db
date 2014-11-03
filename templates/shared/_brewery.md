
.. <!-- put brewery inside a table -->
.. <!--  use 33.33% n 66.66% cols -->

<div class='brewery' id='{{ brewery.key }}'>
<div class='brewery-title' markdown='1'>
{{ brewery_stars( brewery ) }} ++
{{ brewery_title( brewery ) }} ++
{% if brewery.founded.present? %} ++
  - {{ brewery.founded }} ++
{% end %} ++
{{ brewery_tags( brewery ) }} ++
_#{{ brewery.key }}_{:.key}
</div>

<table class='brewery'>
  <tr>
    <td width='33.333%'>
.. <!-- check if activerecord supports address? for present? check - if not add it to model -->
<div class='brewery-details' markdown='1'>
{% if brewery.address.present? %} ++
  {{ brewery.address }}  <br> ++
{% end %}   ++
.. <!-- check if activerecord supports web? for present? check - if not add it to model -->
.. <!-- fix: use web symbol - no need to use br/break - why? why not?? -->
{% if brewery.web.present? %}  ++
  {{ link_to brewery.web, "http://#{brewery.web}" }}  ++
.. <!-- fix: use link_to_brewery_website -->
{% end %}
</div>
  </td>
  <td width='66.666%'>
<div class='beers' markdown='1'>
.. <!-- 2nd column begin -->
.. <!-- check if activerecord supports beers? for assoc count check - if not add it to model -->
{% if brewery.beers.count > 0 %}
  .. <!-- fix: make sure render_beers ends with a newline? why? why not?? -->
  .. <!--  do all render_xxx return a line e.g. ending with newline or just a string (span) without newline??? -->
  {{ render_beers( brewery.beers ) }}
{% end %}
</div>
</td>
  </tr>
</table>
</div>

