import 'package:flutter/material.dart' hide Theme;
import '../providers.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

import '../map.dart';

class ThunderforestExample extends StatelessWidget {
  const ThunderforestExample({super.key});

  @override
  Widget build(BuildContext context) => MapWidget(
      layerFactory: (context) => VectorTileLayer(
          tileProviders: TileProviders(
              {'thunderforest_outdoors': Providers.thunderForestOutdoorsV2()}),
          theme: ThemeReader().read(thunderStyle())));
}

dynamic thunderStyle() => {
      "version": 8,
      "name": "Empty Style",
      "metadata": {"maputnik:renderer": "mbgljs"},
      "sources": {
        "thunderforest_outdoors": {
          "type": "vector",
          "url":
              "https://tile.thunderforest.com/thunderforest.outdoors-v2.json?apikey="
        }
      },
      "sprite": "",
      "glyphs":
          "https://orangemug.github.io/font-glyphs/glyphs/{fontstack}/{range}.pbf",
      "layers": [
        {
          "id": "background",
          "type": "background",
          "paint": {"background-color": "#EEEEEE"}
        },
        {
          "id": "protected-areas",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "protected-area",
          "minzoom": 8,
          "filter": [
            "all",
            [
              "in",
              "type",
              "park",
              "national_park",
              "nature_reserve",
              "protected_area"
            ]
          ],
          "paint": {"fill-color": "#81c784", "fill-opacity": 0.5}
        },
        {
          "id": "park",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "landuse",
          "minzoom": 8,
          "filter": [
            "all",
            ["in", "type", "park"]
          ],
          "paint": {"fill-color": "#81c784", "fill-opacity": 0.5}
        },
        {
          "id": "landcover_gwsif",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "landcover",
          "filter": [
            "all",
            [
              "in",
              "type",
              "grass",
              "sand",
              "wood",
              "forest",
              "beach",
              "scree",
              "grassland",
              "bare_rock",
              "meadow",
              "scrub"
            ]
          ],
          "paint": {
            "fill-color": [
              "match",
              ["get", "type"],
              "sand",
              "#fffde7",
              "beach",
              "#fffde7",
              "ice",
              "rgba(206, 240, 253, 1)",
              "scree",
              "#d6d6d6",
              "bare_rock",
              "#d6d6d6",
              "#81c784"
            ],
            "fill-opacity": [
              "match",
              ["get", "type"],
              "grass",
              0.2,
              "grassland",
              0.2,
              "meadow",
              0.2,
              "wood",
              0.5,
              "forest",
              0.5,
              "scrub",
              0.5,
              "ice",
              0.8,
              "scree",
              0.2,
              "bare_rock",
              0.2,
              1
            ]
          }
        },
        {
          "id": "glacier",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "glacier",
          "filter": ["all"],
          "paint": {"fill-color": "rgba(206, 240, 253, 0.8)"}
        },
        {
          "id": "landuse_special",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "landuse",
          "minzoom": 15,
          "filter": [
            "all",
            ["in", "type", "cemetary", "school", "hospital"]
          ],
          "paint": {"fill-color": "#eceff1", "fill-outline-color": "#cfd8dc"}
        },
        {
          "id": "poi_area_special",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "poi-area",
          "minzoom": 15,
          "filter": [
            "all",
            ["in", "feature", "cemetary", "hospital"]
          ],
          "paint": {"fill-color": "#eceff1", "fill-outline-color": "#cfd8dc"}
        },
        {
          "id": "ocean",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "ocean",
          "paint": {"fill-color": "#bbdefb"}
        },
        {
          "id": "water",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "water",
          "minzoom": 5,
          "paint": {"fill-color": "#bbdefb"}
        },
        {
          "id": "water_feature",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "water-feature",
          "minzoom": 12,
          "filter": [
            "all",
            [
              "in",
              "type",
              "breakwater",
              "pier",
              "dam",
              "breakwater",
              "lock_gate"
            ]
          ],
          "paint": {"fill-opacity": 1, "fill-color": "#e0e0e0"}
        },
        {
          "id": "water_featuree_line",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "water-feature",
          "minzoom": 12,
          "filter": [
            "all",
            [
              "in",
              "type",
              "breakwater",
              "pier",
              "dam",
              "breakwater",
              "lock_gate"
            ]
          ],
          "paint": {
            "line-opacity": 1,
            "line-color": "#e0e0e0",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              11,
              0.5,
              20,
              3
            ]
          }
        },
        {
          "id": "waterway_river",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "waterway",
          "minzoom": 9,
          "filter": [
            "all",
            ["!=", "tunnel", "yes"],
            ["==", "waterway", "river"]
          ],
          "layout": {"line-cap": "round", "line-join": "round"},
          "paint": {
            "line-color": "#bbdefb",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              11,
              0.5,
              20,
              6
            ]
          }
        },
        {
          "id": "waterway_other",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "waterway",
          "minzoom": 9,
          "filter": [
            "all",
            ["!=", "tunnel", "yes"],
            ["!=", "waterway", "river"]
          ],
          "layout": {"line-cap": "round", "line-join": "round"},
          "paint": {
            "line-color": "#bbdefb",
            "line-width": [
              "interpolate",
              ["exponential", 1.3],
              ["zoom"],
              13,
              0.5,
              20,
              6
            ]
          }
        },
        {
          "id": "contour_major",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "elevation",
          "minzoom": 12,
          "filter": [
            "all",
            ["==", "priority", "major"],
            [">", "height", 10]
          ],
          "paint": {
            "line-color": "#66bb6a",
            "line-width": {
              "stops": [
                [10, 0.5],
                [15, 1]
              ]
            }
          }
        },
        {
          "id": "contour_medium",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "elevation",
          "minzoom": 13,
          "filter": [
            "all",
            ["==", "priority", "medium"],
            [">", "height", 10]
          ],
          "paint": {
            "line-color": "#81c784",
            "line-width": {
              "stops": [
                [15, 0.5],
                [16, 1]
              ]
            }
          }
        },
        {
          "id": "contour_minor",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "elevation",
          "minzoom": 15,
          "filter": [
            "all",
            ["==", "priority", "minor"],
            [">", "height", 10]
          ],
          "paint": {"line-color": "#81c784", "line-width": 0.5}
        },
        {
          "id": "hillshade_shadow_dark",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "hillshade",
          "filter": [
            "all",
            ["==", "level", 110]
          ],
          "paint": {"fill-color": "rgba(0,0,0,0.06)"}
        },
        {
          "id": "hillshade_shadow_medium",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "hillshade",
          "filter": [
            "all",
            ["==", "level", 130]
          ],
          "paint": {"fill-color": "rgba(0,0,0,0.06)"}
        },
        {
          "id": "hillshade_shadow_light",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "hillshade",
          "filter": [
            "all",
            ["==", "level", 150]
          ],
          "paint": {"fill-color": "rgba(0,0,0,0.04)"}
        },
        {
          "id": "hillshade_highlight_light",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "hillshade",
          "filter": [
            "all",
            ["==", "level", 200]
          ],
          "paint": {"fill-color": "rgba(255,255,255,0.08)"}
        },
        {
          "id": "hillshade_highlight_bright",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "hillshade",
          "filter": [
            "all",
            ["==", "level", 220]
          ],
          "paint": {"fill-color": "rgba(255,255,255,0.09)"}
        },
        {
          "id": "hillshade_highlight_brightest",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "hillshade",
          "filter": [
            "any",
            [">=", "level", 225]
          ],
          "paint": {"fill-color": "rgba(255,255,255,0.08)"}
        },
        {
          "id": "waterway_tunnel",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "waterway",
          "minzoom": 9,
          "filter": [
            "all",
            ["==", "tunnel", "yes"]
          ],
          "layout": {"line-cap": "round", "line-join": "round"},
          "paint": {
            "line-color": "#b0bec5",
            "line-width": [
              "interpolate",
              ["exponential", 1.4],
              ["zoom"],
              8,
              1,
              20,
              2
            ]
          }
        },
        {
          "id": "aeroway_area",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "aeroway-area",
          "minzoom": 10,
          "paint": {"fill-color": "#0e0e0e", "fill-opacity": 0.05}
        },
        {
          "id": "aeroway_taxiway",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "aeroway",
          "minzoom": 10,
          "filter": [
            "all",
            ["==", "aeroway", "taxiway"]
          ],
          "paint": {
            "line-color": "#fafafa",
            "line-width": {
              "base": 1.2,
              "stops": [
                [11, 1.5],
                [20, 24]
              ]
            }
          }
        },
        {
          "id": "aeroway_runway",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "aeroway",
          "minzoom": 10,
          "filter": [
            "all",
            ["==", "aeroway", "runway"]
          ],
          "paint": {
            "line-color": "#fafafa",
            "line-width": {
              "base": 1.2,
              "stops": [
                [11, 2],
                [20, 70]
              ]
            }
          }
        },
        {
          "id": "road_area",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "road-area",
          "minzoom": 14,
          "paint": {"fill-color": "rgba(245, 245, 245, 0.4)"}
        },
        {
          "id": "railway",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "railway",
          "minzoom": 11,
          "paint": {"line-color": "#ccc", "line-width": 2}
        },
        {
          "id": "railway_texture",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "railway",
          "minzoom": 13,
          "paint": {
            "line-dasharray": [0.2, 8],
            "line-color": "#ccc",
            "line-width": [
              "step",
              ["zoom"],
              0,
              10,
              6,
              18,
              16
            ]
          }
        },
        {
          "id": "path_bridge_pedestrian_casing",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "path",
          "minzoom": 15,
          "filter": [
            "all",
            ["==", "bridge", "yes"]
          ],
          "paint": {
            "line-color": "#e0e0e0",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              14,
              1.5,
              20,
              18
            ]
          }
        },
        {
          "id": "path_bridge_pedestrian",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "path",
          "minzoom": 14,
          "filter": [
            "all",
            ["==", "bridge", "yes"]
          ],
          "paint": {
            "line-color": "#ffffff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              14,
              0.5,
              20,
              10
            ]
          }
        },
        {
          "id": "path_pedestrian_lowzoom",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "path",
          "minzoom": 14,
          "maxzoom": 15,
          "filter": [
            "all",
            ["!=", "bridge", "yes"]
          ],
          "paint": {
            "line-color": "#ffffff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              14,
              0.5,
              20,
              10
            ]
          }
        },
        {
          "id": "path_pedestrian",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "path",
          "minzoom": 15.000000001,
          "maxzoom": 18,
          "filter": [
            "all",
            ["!=", "bridge", "yes"]
          ],
          "paint": {
            "line-dasharray": [1, 0.7],
            "line-color": "#ffffff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              14,
              0.5,
              20,
              10
            ]
          }
        },
        {
          "id": "path_pedestrian_highzoom",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "path",
          "minzoom": 18.0000001,
          "maxzoom": 24,
          "filter": [
            "all",
            ["!=", "bridge", "yes"]
          ],
          "paint": {
            "line-dasharray": [1, 0.2],
            "line-color": "#ffffff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              14,
              0.5,
              20,
              10
            ]
          }
        },
        {
          "id": "road_service_track_casing",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 15,
          "filter": [
            "all",
            ["in", "highway", "service", "track", "living_street", "raceway"]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              15,
              1,
              16,
              4,
              20,
              15
            ]
          }
        },
        {
          "id": "road_ramp_casing",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 10,
          "filter": [
            "all",
            ["in", "highway", "motorway_link", "trunk_link"]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              12,
              1,
              13,
              3,
              14,
              4,
              20,
              15
            ]
          }
        },
        {
          "id": "road_residential_minor_casing",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 13.5,
          "filter": [
            "all",
            ["in", "highway", "residential", "unclassified", "minor"]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": {
              "base": 1.2,
              "stops": [
                [12, 0.5],
                [13, 1],
                [14, 4],
                [20, 20]
              ]
            }
          }
        },
        {
          "id": "road_secondary_tertiary_casing",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 13,
          "filter": [
            "all",
            [
              "in",
              "highway",
              "secondary",
              "secondary_link",
              "tertiary",
              "tertiary_link"
            ]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": {
              "base": 1.2,
              "stops": [
                [8, 3.5],
                [13, 5],
                [20, 17]
              ]
            }
          }
        },
        {
          "id": "road_motorway_casing",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 6,
          "filter": [
            "all",
            ["in", "highway", "motorway", "trunk"]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              5,
              0.4,
              6,
              0.7,
              7,
              1.75,
              20,
              22
            ]
          }
        },
        {
          "id": "road_primary_casing",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 9,
          "filter": [
            "all",
            ["in", "highway", "primary", "primary_link"]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              5,
              0.4,
              6,
              0.7,
              7,
              1.75,
              20,
              22
            ]
          }
        },
        {
          "id": "road_service_track",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 15,
          "filter": [
            "all",
            ["in", "highway", "service", "track", "living_street", "raceway"]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#fff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              15.5,
              0,
              16,
              2.5,
              20,
              12
            ]
          }
        },
        {
          "id": "road_residential_minor",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "highway", "residential", "unclassified", "minor"]
          ],
          "layout": {"line-join": "round", "line-cap": "round"},
          "paint": {
            "line-color": "#fff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [12.5, 0],
                [14, 2.5],
                [20, 18]
              ]
            }
          }
        },
        {
          "id": "road_secondary_tertiary",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 13,
          "filter": [
            "all",
            [
              "in",
              "highway",
              "secondary",
              "secondary_link",
              "tertiary",
              "tertiary_link"
            ]
          ],
          "layout": {"line-join": "round", "line-cap": "round"},
          "paint": {
            "line-color": "#fff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [6.5, 0],
                [8, 2.5],
                [13, 4],
                [20, 13]
              ]
            }
          }
        },
        {
          "id": "road_secondary_tertiary_basic",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 10,
          "maxzoom": 12.9999,
          "filter": [
            "all",
            [
              "in",
              "highway",
              "secondary",
              "secondary_link",
              "tertiary",
              "tertiary_link"
            ]
          ],
          "layout": {"line-join": "round", "line-cap": "butt"},
          "paint": {
            "line-color": "#fff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              6.5,
              0,
              8,
              1.5,
              20,
              2
            ]
          }
        },
        {
          "id": "road_ramp",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 10,
          "maxzoom": 24,
          "filter": [
            "all",
            ["in", "highway", "motorway_link", "trunk_link"]
          ],
          "layout": {"line-join": "round"},
          "paint": {
            "line-color": "#fff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              12.5,
              0,
              13,
              1.5,
              14,
              2.5,
              20,
              11.5
            ]
          }
        },
        {
          "id": "road_motorway",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 6,
          "maxzoom": 24,
          "filter": [
            "all",
            ["in", "highway", "motorway", "trunk"]
          ],
          "layout": {"line-join": "round", "line-cap": "round"},
          "paint": {
            "line-color": "#fff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              5,
              0,
              7,
              1,
              20,
              18
            ]
          }
        },
        {
          "id": "road_primary",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "road",
          "minzoom": 6,
          "maxzoom": 24,
          "filter": [
            "all",
            ["in", "highway", "primary", "primary_link"]
          ],
          "layout": {"line-join": "round", "line-cap": "round"},
          "paint": {
            "line-color": "#fff",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              5,
              0,
              7,
              1,
              20,
              18
            ]
          }
        },
        {
          "id": "boundary",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "country-line",
          "minzoom": 3,
          "filter": [
            "all",
            ["==", "type", "Land"]
          ],
          "paint": {
            "line-color": "#aaa",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              1,
              1,
              9,
              2
            ]
          }
        },
        {
          "id": "boundary-state",
          "type": "line",
          "source": "thunderforest_outdoors",
          "source-layer": "state-line",
          "minzoom": 3,
          "maxzoom": 10,
          "filter": [
            "all",
            ["<=", "scalerank", 2]
          ],
          "paint": {
            "line-color": "#d6d6d6",
            "line-width": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              1,
              1,
              9,
              2
            ]
          }
        },
        {
          "id": "buildings",
          "type": "fill",
          "source": "thunderforest_outdoors",
          "source-layer": "building",
          "minzoom": 15.8,
          "paint": {"fill-color": "#e0e0e0", "fill-outline-color": "#bdbdbd"}
        },
        {
          "id": "place_label_city",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "place-label",
          "minzoom": 6,
          "filter": [
            "any",
            ["==", "place", "city"],
            ["==", "place_priority", 1]
          ],
          "layout": {
            "text-font": ["Roboto Regular"],
            "icon-anchor": "bottom",
            "text-field": "{name}",
            "text-size": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              7,
              12,
              11,
              16,
              18,
              18
            ]
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "place_label_town",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "place-label",
          "minzoom": 12,
          "maxzoom": 15,
          "filter": [
            "any",
            ["in", "place", "town"],
            ["in", "place_priority", 2, 3]
          ],
          "layout": {
            "text-field": "{name}",
            "text-font": ["Roboto Condensed Italic"],
            "text-max-width": 8,
            "text-offset": [0, 0],
            "text-size": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              12,
              10,
              15,
              14,
              18,
              16
            ],
            "text-transform": "uppercase"
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "place_label_suburb",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "place-label",
          "minzoom": 12,
          "maxzoom": 14,
          "filter": [
            "any",
            ["in", "place", "suburb"],
            ["in", "place_priority", 2, 3]
          ],
          "layout": {
            "text-field": "{name}",
            "text-font": ["Roboto Condensed Italic"],
            "text-max-width": 8,
            "text-offset": [0, 0],
            "text-size": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              12,
              10,
              15,
              14,
              18,
              16
            ],
            "text-transform": "uppercase"
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "place_label_other",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "place-label",
          "minzoom": 13,
          "maxzoom": 24,
          "filter": [
            "any",
            [">", "place_priority", 3],
            ["in", "place", "island"]
          ],
          "layout": {
            "text-field": "{name}",
            "text-font": ["Roboto Condensed Italic"],
            "text-max-width": 8,
            "text-offset": [0, 0],
            "text-size": [
              "interpolate",
              ["exponential", 1.2],
              ["zoom"],
              12,
              10,
              15,
              14,
              18,
              16
            ],
            "text-transform": "uppercase"
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "country_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "country-label",
          "maxzoom": 9,
          "filter": [
            "all",
            ["<=", "labelrank", 5]
          ],
          "layout": {
            "text-font": ["Roboto Regular"],
            "icon-anchor": "bottom",
            "text-field": "{name_en}",
            "text-size": {
              "stops": [
                [1, 10],
                [4, 14]
              ]
            }
          },
          "paint": {
            "text-color": "#334",
            "text-halo-blur": 1,
            "text-halo-color": "rgba(255,255,255,0.8)",
            "text-halo-width": 1
          }
        },
        {
          "id": "state_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "state-label",
          "minzoom": 5,
          "maxzoom": 10,
          "filter": ["all"],
          "layout": {
            "text-font": ["Roboto Regular"],
            "icon-anchor": "bottom",
            "text-field": "{name}",
            "text-size": {
              "stops": [
                [1, 10],
                [4, 14]
              ]
            }
          },
          "paint": {
            "text-color": "#334",
            "text-halo-blur": 1,
            "text-halo-color": "rgba(255,255,255,0.8)",
            "text-halo-width": 1
          }
        },
        {
          "id": "poi_peak_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "poi-label",
          "minzoom": 12,
          "maxzoom": 14,
          "filter": [
            "all",
            ["==", "feature", "peak"]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "aeroway_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "aeroway-label",
          "minzoom": 13,
          "filter": [
            "all",
            ["==", "aeroway", "aerodrome"]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "water_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "water-label",
          "minzoom": 10,
          "filter": [
            "all",
            ["in", "type", "water"],
            [">=", "way_area", 8000]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "water_bay",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "water-label",
          "minzoom": 10,
          "filter": [
            "all",
            ["in", "type", "bay"],
            [">=", "way_area", 25000000]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "water_label_highzoom",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "water-label",
          "minzoom": 17,
          "filter": [
            "all",
            ["in", "type", "water"],
            ["<", "way_area", 8000]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "landuse_park_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "landuse-label",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "type", "park"],
            [">=", "way_area", 50000]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "landuse_park_label_highzoom",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "landuse-label",
          "minzoom": 17,
          "filter": [
            "all",
            ["in", "type", "park"],
            ["<", "way_area", 50000]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "landuse_school_hospital_other_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "landuse-label",
          "minzoom": 14,
          "filter": [
            "all",
            ["in", "type", "school", "hospital", "castle", "stadium"]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-size": {
              "base": 1,
              "stops": [
                [13, 12],
                [14, 13],
                [18, 16]
              ]
            }
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "road_motorway_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "road-label",
          "minzoom": 11,
          "filter": [
            "all",
            ["==", "highway", "motorway"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": [
              "string",
              ["get", "name"],
              ["get", "ref"]
            ],
            "text-font": ["Roboto Regular"],
            "text-size": [
              "interpolate",
              ["linear"],
              ["zoom"],
              13,
              12,
              14,
              13,
              18,
              16
            ]
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "road_trunk_primary_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "road-label",
          "minzoom": 12,
          "filter": [
            "all",
            ["in", "highway", "primary", "trunk"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": [
              "string",
              ["get", "name"],
              ["get", "ref"]
            ],
            "text-font": ["Roboto Regular"],
            "text-size": [
              "interpolate",
              ["linear"],
              ["zoom"],
              13,
              12,
              14,
              13,
              18,
              16
            ]
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "road_secondary_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "road-label",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "highway", "secondary", "tertiary"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": [
              "string",
              ["get", "name"],
              ["get", "ref"]
            ],
            "text-font": ["Roboto Regular"],
            "text-size": [
              "interpolate",
              ["linear"],
              ["zoom"],
              13,
              12,
              14,
              13,
              18,
              16
            ]
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "road_minor_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "road-label",
          "minzoom": 15,
          "filter": [
            "all",
            [
              "in",
              "highway",
              "residential",
              "unclassified",
              "living_street",
              "service",
              "track",
              "raceway"
            ]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": [
              "string",
              ["get", "name"],
              ["get", "ref"]
            ],
            "text-font": ["Roboto Regular"],
            "text-size": [
              "interpolate",
              ["linear"],
              ["zoom"],
              13,
              12,
              14,
              13,
              18,
              16
            ]
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "road_path_label",
          "type": "symbol",
          "source": "thunderforest_outdoors",
          "source-layer": "path-label",
          "minzoom": 15,
          "filter": [
            "all",
            ["in", "highway", "path", "cycleway"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": [
              "string",
              ["get", "name"],
              ["get", "ref"]
            ],
            "text-font": ["Roboto Regular"],
            "text-size": [
              "interpolate",
              ["linear"],
              ["zoom"],
              13,
              12,
              14,
              13,
              18,
              16
            ]
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        }
      ],
      "id": "epicrideweather"
    };
