@road: mix(@bgDark, @land, 40%);
@road_casing: darken(@road, 5%);
@road_small:  mix(@bgDark, @land, 25%);
@road_small_casing: darken(@road_small, 5%);

// ---------------------------------------------------------------------

// Roads are split across 3 layers: #road, #bridge, and #tunnel. Each
// road segment will only exist in one of the three layers. The
// #bridge layer makes use of Mapnik's group-by rendering mode;
// attachments in this layer will be grouped by layer for appropriate
// rendering of multi-level overpasses.

// The main road style is for all 3 road layers and divided into 2 main
// attachments. The 'case' attachment is 

#road, #bridge, #tunnel {
  // casing/outlines & single lines
  ::case[zoom>=8]['mapnik::geometry_type'=2] {
    [class='motorway'],
    [type='trunk']{
      opacity: 1;
      line-join:round;
      line-color: @road_casing;
      //#road { line-cap: round; }
      #tunnel { opacity:.5; }
      [zoom>=8] { line-width:3; }
      [zoom>=10]  { line-width:7; }
      [zoom>=12] { line-width:11;  }
      [zoom>=14] { line-width:12;  }      
      [zoom>=15] { line-width:14; }
      [zoom>=16] { line-width:16; }
      [zoom>=17] { line-width:20; }      
    }

    [class='main'][zoom>=12],
    [class='motorway_link'][zoom>=13] {
      line-join:round;
      line-color:@road_small_casing;
      #road { line-cap: round; }
      #tunnel { line-dasharray:3,2; }
      [zoom>=14] { line-width:7; }
      [zoom>=15] { line-width:9; }
      [zoom>=16] { line-width:13; }
      [zoom>=17] { line-width:16; }
    }

  }

  
  
  // fill/inlines

    [class='main'][zoom>=10],
    [class='motorway_link'][zoom>=13]{
      line-join:round;
      #road, #bridge { line-cap: round; }
      line-color:@road_small;
      #tunnel { opacity: .5 }
      [zoom>=10] { line-width:2; }
      [zoom>=12] { line-width:3; }
      [zoom>=14] { line-width:4; }
      [zoom>=15] { line-width:5; }
      [zoom>=16] { line-width:8; }
      [zoom>=17] { line-width:10; }
    }
    [class='street'][zoom>=15],
    [class='street_limited'][zoom>=15],
    [class='service'][zoom>=16],
    [class='path'][zoom>=16]{
      line-join:round;
      #road, #bridge { line-cap: round; }
      [zoom>=14] { line-width:3; line-color:@road_small; }
      [zoom>=16] { line-width:7; }
      [zoom>=17] { line-width:8; }
      [class='path'] {
        [zoom>=16] { line-width:3; }
        line-join: bevel;
        line-cap: butt;
        line-dasharray:5,2;
      }
    }

    [class='major_rail'] {
      line-width: 0.4;
      line-color: #bbb;
      [zoom>=16] {
        line-width: 0.75;
      	// Hatching
      	h/line-width: 3;
      	h/line-color: #bbb;
      	h/line-dasharray: 1,31;
      }
    }
  
  ::fill[zoom>=6]['mapnik::geometry_type'=2] {
    [class='motorway'][zoom>=8],
    [type='trunk']
  {
      line-join:round;
      #road, #bridge { line-cap:round; }
      line-color:@road;
      #tunnel { line-color:@road; }
      [zoom>=8] { line-width:1.5; }
      [zoom>=10] { line-width:3; }
      [zoom>=12] { line-width:5; }
      [zoom>=14] { line-width:5; }
      [zoom>=15] { line-width:6; }
      [zoom>=16] { line-width:7; }
      [zoom>=17] { line-width:10; }
    }
  
  
  }
}
