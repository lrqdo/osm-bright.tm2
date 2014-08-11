// ---------------------------------------------------------------------
// Common Colors

// You don't need to set up @variables for every color, but it's a good
// idea for colors you might be using in multiple places or as a base
// color for a variety of tints.
// Eg. @water is used in the #water and #waterway layers directly, but
// also in the #water_label and #waterway_label layers inside a color
// manipulation function to get a darker shade of the same hue.

@maroon1: rgb(194,131,126);
@maroon3: rgb(92,39,47);
@land: #ffffff;
@water: #BEEFF8 ;

Map {
  background-color: @land;
}

// ---------------------------------------------------------------------
// Political boundaries
#admin[admin_level=2][maritime=0]
[osm_id!= 210347008] 
[osm_id!= 210347006]
[osm_id!= 224452841]
[osm_id!=171276812 ]
[osm_id!=171276814 ]
[osm_id!=171276811 ]
[osm_id!=62043868 ]
[osm_id!=91454145 ]
[osm_id!=62043846 ]
[osm_id!=121758376 ]
[osm_id!=121758379 ]
[osm_id!=121758378 ]
[osm_id!=62043869 ]
[osm_id!=147135317 ]
[osm_id!=56716725 ]
[osm_id!=99321199 ]
[osm_id!= 4543112 ]
[osm_id!=171146740 ]
[osm_id!=170393704 ]
[osm_id!=170395404 ]
[osm_id!=35881034 ]
[osm_id!=232710933 ]
[osm_id!=232710932 ]
[osm_id!=232710938 ]
[osm_id!=232710930 ]
[osm_id!=232710926 ]
[osm_id!=4537335 ]
[osm_id!=4537349 ]
[osm_id!=219322830 ]
[osm_id!=219135746 ]
[osm_id!=210268275 ]
[osm_id!=210303898 ]
[osm_id!=210268274 ]
[osm_id!=210345464 ]
[osm_id!=210348041 ]
[osm_id!=210351410 ]
[osm_id!=210355109 ]
[osm_id!=210570699 ]
[osm_id!=210355109 ]
[osm_id!=210570715 ]
[osm_id!=230466889 ]
[osm_id!=230466886 ]
[osm_id!=230466789 ]
[osm_id!=230466882 ]
[osm_id!=230466861 ]
[osm_id!=230466888 ]

{
  opacity: .5;
  line-width: 1.5;
  line-join: round;
  line-color: @maroon3;
      [zoom>=8] { line-width: 2.5; }
    [zoom>=12] { line-width: 4; }
}

#admin[admin_level>=3][zoom>=6] {
  opacity: .3;
  line-width: .5;
  line-join: round;
  line-color: @maroon3;
    [zoom>=8] { line-width: 1.5; }
    [zoom>=12] { line-width: 2; }
}

/*
#admin {
 
  opacity: 0.5;
  line-join: round;
  line-color: #446;
  

  
  // Countries
  [admin_level=2] {
    opacity: 1;
    line-color: #446;
    line-join: round;
    line-width: 1.4;
    line-cap: round;
    [zoom>=6] { line-width: 2; }
    [zoom>=8] { line-width: 4; }
    [disputed=1] { line-dasharray: 4,4; }
  }
  // States / Provices / Subregions
  [admin_level>=3][zoom>=6] {
    line-width: 0.4;
    line-dasharray: 10,3,3,3;
    [zoom>=6] { line-width: 1; }
    [zoom>=8] { line-width: 1.5; }
    [zoom>=12] { line-width: 2; }
  }
  
  
}*/

// ---------------------------------------------------------------------
// Water Features 

#water {
  polygon-fill: @water - #111;
  // Map tiles are 256 pixels by 256 pixels wide, so the height 
  // and width of tiling pattern images must be factors of 256. 
  //polygon-pattern-file: url(pattern/wave.png);
  [zoom<=5] {
    // Below zoom level 5 we use Natural Earth data for water,
    // which has more obvious seams that need to be hidden.
    polygon-gamma: 0.4;
  }
  ::blur {
    // This attachment creates a shadow effect by creating a
    // light overlay that is offset slightly south. It also
    // create a slight highlight of the land along the
    // southern edge of any water body.
    polygon-fill: #f0f0ff;
    comp-op: soft-light;
    image-filters: agg-stack-blur(10,10);
    polygon-geometry-transform: translate(0,1);
    polygon-clip: false;
  }
}

#waterway {
  line-color: @water * 0.9;
  line-cap: round;
  line-width: 0.5;
  [type='river'] {
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [type='stream'],
  [type='canal'] {
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
}

// ---------------------------------------------------------------------
// Landuse areas 

#landuse {
  // Land-use and land-cover are not well-separated concepts in
  // OpenStreetMap, so this layer includes both. The 'class' field
  // is a highly opinionated simplification of the myriad LULC
  // tag combinations into a limited set of general classes.
  [class='park'][class!='wood'][zoom>=10] { polygon-fill: #d8e8c8; }
  [class='cemetery'] { polygon-fill: mix(#d8e8c8, #ddd, 25%); }
  [class='hospital'] { polygon-fill: #fde; }
  [class='school'] { polygon-fill: #f0e8f8; }

  /*
  ::overlay {
    // Landuse classes look better as a transparent overlay.
    opacity: 0.1;
    [class='wood'] { polygon-fill: #6a4; polygon-gamma: 0.5; }
  }*/
}

// ---------------------------------------------------------------------
// Buildings 
/*
#building [zoom<=17]{
  // At zoom level 13, only large buildings are included in the
  // vector tiles. At zoom level 14+, all buildings are included.
  polygon-fill: darken(@land, 50%);
  opacity: 0.1;
}
// Seperate attachments are used to draw buildings with depth
// to make them more prominent at high zoom levels
#building [zoom>=18]{
::wall { polygon-fill:mix(@land, #000, 85); }
::roof {
  polygon-fill: darken(@land, 5%);
  polygon-geometry-transform:translate(-1,-1.5);
  polygon-clip:false;  
  line-width: 0.5;
  line-color: mix(@land, #000, 85);
  line-geometry-transform:translate(-1,-1.5);
  line-clip:false;
 }
}
*/

// ---------------------------------------------------------------------
// Aeroways 

#aeroway [zoom>=12] {
  ['mapnik::geometry_type'=2] {
    line-color: @land * 0.96;
    [type='runway'] { line-width: 5; }    
    [type='taxiway'] {  
      line-width: 1;
      [zoom>=15] { line-width: 2; }
    }
  }    
  ['mapnik::geometry_type'=3] {
    polygon-fill: @land * 0.96;
    [type='apron'] {
      polygon-fill: @land * 0.98;  
    }  
  }
}



