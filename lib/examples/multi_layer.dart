import 'package:flutter/material.dart';
import 'package:vector_map_examples/map.dart';
import 'package:vector_map_examples/providers.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

class MultiLayerExample extends StatelessWidget {
  const MultiLayerExample({super.key});

  @override
  Widget build(BuildContext context) => MapWidget(layerFactories: [
        // This example shows having multiple vector tile layers,
        // however any widget can be used. For example, vector tile layers
        // could be combined with any other map layer from flutter_map or
        // third party plugins.
        (context, layerMode) => VectorTileLayer(
            key: const Key('map_bottom_layer'),
            layerMode: VectorTileLayerMode.raster,
            tileOffset: const TileOffset(zoomOffset: 0),
            tileProviders:
                TileProviders({'openmaptiles': Providers.stadiaMaps()}),
            theme: ThemeReader().read(_baseLayerStyle())),
        // The top layer must not have a style with an opaque background layer in it
        // otherwise the background layer will draw over other layers causing them
        // to be invisible.
        (context, layerMode) => VectorTileLayer(
            key: const Key('map_top_layer'),
            layerMode: layerMode,
            tileProviders:
                TileProviders({'openmaptiles': Providers.stadiaMaps()}),
            theme: ThemeReader().read(_topLayerStyle()))
      ]);
}

dynamic _baseLayerStyle() => {
      "version": 8,
      "name": "Base Style",
      "metadata": {"maputnik:renderer": "mbgljs", "version": "19"},
      "sources": {
        "openmaptiles": {
          "type": "vector",
          "url": "https://api.maptiler.com/tiles/v3/tiles.json?key={key}"
        },
        "hillshade": {"type": "vector", "url": ""}
      },
      "layers": [
        {
          "id": "background",
          "type": "background",
          "paint": {"background-color": "#EEEEEE"}
        },
        {
          "id": "park",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "park",
          "paint": {"fill-color": "#81c784", "fill-opacity": 0.5}
        },
        {
          "id": "landcover_grass_wood_sand_ice",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "landcover",
          "filter": ["in", "class", "grass", "wood", "sand", "ice"],
          "paint": {
            "fill-color": [
              "match",
              ["get", "class"],
              "sand",
              "#fffde7",
              "ice",
              "rgba(206, 240, 253, 1)",
              "#81c784"
            ],
            "fill-opacity": [
              "match",
              ["get", "class"],
              "grass",
              0.2,
              "wood",
              0.5,
              "ice",
              0.8,
              1.0
            ]
          }
        },
        {
          "id": "landuse_special",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "landuse",
          "minzoom": 15.0,
          "filter": ["in", "class", "cemetery", "hospital", "school"],
          "paint": {"fill-color": "#eceff1", "fill-outline-color": "#cfd8dc"}
        },
        {
          "id": "water",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "water",
          "filter": [
            "all",
            ["!=", "brunnel", "tunnel"]
          ],
          "paint": {"fill-color": "#bbdefb"}
        },
        {
          "id": "park",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "park",
          "paint": {"fill-color": "#81c784", "fill-opacity": 0.5}
        },
        {
          "id": "landcover_grass_wood_sand_ice",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "landcover",
          "filter": ["in", "class", "grass", "wood", "sand", "ice"],
          "paint": {
            "fill-color": [
              "match",
              ["get", "class"],
              "sand",
              "#fffde7",
              "ice",
              "rgba(206, 240, 253, 1)",
              "#81c784"
            ],
            "fill-opacity": [
              "match",
              ["get", "class"],
              "grass",
              0.2,
              "wood",
              0.5,
              "ice",
              0.8,
              1.0
            ]
          }
        },
        {
          "id": "landuse_special",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "landuse",
          "minzoom": 15.0,
          "filter": ["in", "class", "cemetery", "hospital", "school"],
          "paint": {"fill-color": "#eceff1", "fill-outline-color": "#cfd8dc"}
        },
        {
          "id": "water",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "water",
          "filter": [
            "all",
            ["!=", "brunnel", "tunnel"]
          ],
          "paint": {"fill-color": "#bbdefb"}
        },
        {
          "id": "hillshade_shadow",
          "type": "fill",
          "source": "hillshade",
          "source-layer": "hillshade",
          "filter": [
            "all",
            ["==", "class", "shadow"],
            ["in", "level", 89, 78, 67, 56]
          ],
          "paint": {
            "fill-color": "#000",
            "fill-opacity": [
              "match",
              ["get", "level"],
              89,
              0.02,
              78,
              0.04,
              67,
              0.06,
              56,
              0.08
            ]
          }
        },
        {
          "id": "hillshade_highlight",
          "type": "fill",
          "source": "hillshade",
          "source-layer": "hillshade",
          "filter": [
            "all",
            ["==", "class", "highlight"],
            ["in", "level", 90, 94]
          ],
          "paint": {
            "fill-color": "#fff",
            "fill-opacity": [
              "match",
              ["get", "level"],
              90,
              0.04,
              94,
              0.08
            ]
          }
        },
        {
          "id": "aeroway",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "aeroway",
          "minzoom": 10,
          "paint": {"fill-color": "#0e0e0e", "fill-opacity": 0.05}
        },
        {
          "id": "aeroway_lines",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "aeroway",
          "minzoom": 9,
          "filter": ["==", "\$type", "LineString"],
          "paint": {
            "line-color": "#fafafa",
            "line-width": [
              "match",
              ["get", "class"],
              "runway",
              {
                "base": 1.2,
                "stops": [
                  [11, 2],
                  [16, 20]
                ]
              },
              {
                "base": 1.2,
                "stops": [
                  [11, 1.2],
                  [20, 14]
                ]
              }
            ]
          }
        },
        {
          "id": "transportation_pattern",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "filter": [
            "all",
            ["==", "\$type", "Polygon"]
          ],
          "paint": {"fill-color": "rgba(245, 245, 245, 0.4)"}
        },
        {
          "id": "waterway_tunnel",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "waterway",
          "filter": [
            "all",
            ["==", "brunnel", "tunnel"]
          ],
          "layout": {"line-cap": "round", "line-join": "round"},
          "paint": {
            "line-color": "#b0bec5",
            "line-width": {
              "base": 1.4,
              "stops": [
                [8, 1],
                [20, 2]
              ]
            }
          }
        },
        {
          "id": "waterway",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "waterway",
          "filter": ["!=", "brunnel", "tunnel"],
          "layout": {"line-cap": "round", "line-join": "round"},
          "paint": {
            "line-width": [
              "match",
              ["get", "class"],
              "river",
              {
                "base": 1.2,
                "stops": [
                  [11, 0.5],
                  [20, 6]
                ]
              },
              {
                "base": 1.3,
                "stops": [
                  [13, 0.5],
                  [20, 6]
                ]
              }
            ],
            "line-color": "#bbdefb"
          }
        },
        {
          "id": "rail",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 11,
          "filter": [
            "all",
            ["in", "class", "rail"]
          ],
          "paint": {"line-color": "#ccc", "line-width": 2}
        },
        {
          "id": "rail_texture",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "class", "rail"]
          ],
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
          "id": "bridge_path_pedestrian_casing",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 15.0,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["==", "brunnel", "bridge"],
            ["in", "class", "pedestrian", "path"]
          ],
          "paint": {
            "line-color": "#e0e0e0",
            "line-width": {
              "base": 1.2,
              "stops": [
                [14, 1.5],
                [20, 18]
              ]
            }
          }
        },
        {
          "id": "bridge_path_pedestrian",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 14,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["==", "brunnel", "bridge"],
            ["in", "class", "pedestrian", "path"]
          ],
          "paint": {
            "line-color": "#ffffff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [14, 0.5],
                [20, 10]
              ]
            }
          }
        },
        {
          "id": "path_pedestrian_lowzoom",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 14,
          "maxzoom": 15,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["!in", "brunnel", "bridge"],
            ["in", "class", "pedestrian", "path"]
          ],
          "paint": {
            "line-color": "#ffffff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [14, 0.5],
                [20, 10]
              ]
            }
          }
        },
        {
          "id": "path_pedestrian",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 15.000000001,
          "maxzoom": 18,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["!in", "brunnel", "bridge"],
            ["in", "class", "pedestrian", "path"]
          ],
          "paint": {
            "line-color": "#ffffff",
            "line-dasharray": [1, 0.7],
            "line-width": {
              "base": 1.2,
              "stops": [
                [14, 0.5],
                [20, 10]
              ]
            }
          }
        },
        {
          "id": "path_pedestrian_highzoom",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 18.0000001,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["!in", "brunnel", "bridge"],
            ["in", "class", "pedestrian", "path"]
          ],
          "paint": {
            "line-color": "#ffffff",
            "line-dasharray": [1, 0.2],
            "line-width": {
              "base": 1.2,
              "stops": [
                [14, 0.5],
                [20, 10]
              ]
            }
          }
        },
        {
          "id": "road_service_track_casing",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 15.0,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["in", "class", "service", "track"]
          ],
          "layout": {"line-cap": "butt", "line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": {
              "base": 1.2,
              "stops": [
                [15, 1],
                [16, 4],
                [20, 15]
              ]
            }
          }
        },
        {
          "id": "road_minor_casing",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 13.5,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["==", "class", "minor"]
          ],
          "layout": {"line-cap": "butt", "line-join": "round"},
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
          "id": "road_motorway_ramp_casing",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 10,
          "filter": [
            "all",
            ["in", "class", "motorway"],
            ["==", "ramp", 1]
          ],
          "layout": {
            "line-join": "round",
            "line-cap": "butt",
            "visibility": "visible"
          },
          "paint": {
            "line-color": "#dadcdf",
            "line-width": {
              "base": 1.2,
              "stops": [
                [12, 1],
                [13, 3],
                [14, 4],
                [20, 15]
              ]
            }
          }
        },
        {
          "id": "road_secondary_tertiary_casing",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "class", "secondary", "tertiary"]
          ],
          "layout": {"line-join": "round", "line-cap": "butt"},
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
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 6,
          "filter": [
            "all",
            ["in", "class", "motorway"],
            ["!=", "ramp", 1]
          ],
          "layout": {"line-cap": "butt", "line-join": "round"},
          "paint": {
            "line-color": "#dadcdf",
            "line-width": {
              "base": 1.2,
              "stops": [
                [5, 0.4],
                [6, 0.7],
                [7, 1.75],
                [20, 22]
              ]
            }
          }
        },
        {
          "id": "road_primary_casing",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 9,
          "filter": [
            "all",
            ["in", "class", "primary", "trunk"]
          ],
          "layout": {
            "line-cap": "butt",
            "line-join": "round",
            "visibility": "visible"
          },
          "paint": {
            "line-color": "#dadcdf",
            "line-width": {
              "base": 1.2,
              "stops": [
                [5, 0.4],
                [6, 0.7],
                [7, 1.75],
                [20, 22]
              ]
            }
          }
        },
        {
          "id": "road_service_track",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 15,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["in", "class", "service", "track"]
          ],
          "layout": {
            "line-cap": "butt",
            "line-join": "round",
            "visibility": "visible"
          },
          "paint": {
            "line-color": "#ffffff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [15.5, 0],
                [16, 2.5],
                [20, 12]
              ]
            }
          }
        },
        {
          "id": "road_minor",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 13,
          "filter": [
            "all",
            ["==", "\$type", "LineString"],
            ["==", "class", "minor"]
          ],
          "layout": {"line-cap": "butt", "line-join": "round"},
          "paint": {
            "line-color": "#ffffff",
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
          "id": "road_secondary_tertiary-basic",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 10,
          "maxzoom": 12.9999,
          "filter": [
            "all",
            ["in", "class", "secondary", "tertiary"]
          ],
          "layout": {"line-join": "round", "line-cap": "butt"},
          "paint": {
            "line-color": "#ffffff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [6.5, 0],
                [8, 1.5],
                [20, 2]
              ]
            }
          }
        },
        {
          "id": "road_secondary_tertiary",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "class", "secondary", "tertiary"]
          ],
          "layout": {"line-join": "round", "line-cap": "round"},
          "paint": {
            "line-color": "#ffffff",
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
          "id": "road_motorway_ramp",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 10,
          "filter": [
            "all",
            ["in", "class", "motorway"],
            ["==", "ramp", 1]
          ],
          "layout": {
            "line-join": "round",
            "line-cap": "butt",
            "visibility": "visible"
          },
          "paint": {
            "line-color": "#ffffff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [12.5, 0],
                [13, 1.5],
                [14, 2.5],
                [20, 11.5]
              ]
            }
          }
        },
        {
          "id": "road_motorway",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 6,
          "filter": [
            "all",
            ["in", "class", "motorway"],
            ["!=", "ramp", 1]
          ],
          "layout": {
            "line-join": "round",
            "line-cap": "round",
            "visibility": "visible"
          },
          "paint": {
            "line-color": "#ffffff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [5, 0],
                [7, 1],
                [20, 18]
              ]
            }
          }
        },
        {
          "id": "road_primary",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "transportation",
          "minzoom": 9,
          "filter": [
            "all",
            ["in", "class", "primary", "trunk"]
          ],
          "layout": {"line-join": "round", "line-cap": "round"},
          "paint": {
            "line-color": "#ffffff",
            "line-width": {
              "base": 1.2,
              "stops": [
                [5, 0],
                [7, 1],
                [20, 18]
              ]
            }
          }
        },
        {
          "id": "boundary_2",
          "type": "line",
          "source": "openmaptiles",
          "source-layer": "boundary",
          "minzoom": 3,
          "filter": [
            "all",
            ["==", "admin_level", 2],
            ["!=", "maritime", 1]
          ],
          "paint": {
            "line-color": "#aaa",
            "line-width": {
              "base": 1.2,
              "stops": [
                [1, 1],
                [9, 2]
              ]
            }
          }
        },
      ],
      "id": "multi_base_light"
    };

dynamic _topLayerStyle() => {
      "version": 8,
      "name": "Empty Style",
      "metadata": {"maputnik:renderer": "mbgljs", "version": "19"},
      "sources": {
        "openmaptiles": {
          "type": "vector",
          "url": "https://api.maptiler.com/tiles/v3/tiles.json?key={key}"
        },
        "hillshade": {"type": "vector", "url": ""}
      },
      "layers": [
        {
          "id": "buildings",
          "type": "fill",
          "source": "openmaptiles",
          "source-layer": "building",
          "minzoom": 15.8,
          "paint": {"fill-color": "#e0e0e0", "fill-outline-color": "#bdbdbd"}
        },
        {
          "id": "place_city",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "place",
          "minzoom": 6,
          "filter": [
            "all",
            ["==", "class", "city"]
          ],
          "layout": {
            "text-anchor": "bottom",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-max-width": 8,
            "text-offset": [0, 0],
            "text-size": {
              "base": 1.2,
              "stops": [
                [7, 12],
                [11, 16],
                [18, 18]
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
          "id": "country_1",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "place",
          "maxzoom": 8,
          "filter": [
            "all",
            ["<=", "rank", 5],
            ["==", "class", "country"]
          ],
          "layout": {
            "text-field": "{name_en}",
            "text-max-width": 6.25,
            "text-size": {
              "stops": [
                [1, 10],
                [4, 14]
              ]
            },
            "text-transform": "none"
          },
          "paint": {
            "text-color": "#334",
            "text-halo-blur": 1,
            "text-halo-color": "rgba(255,255,255,0.8)",
            "text-halo-width": 1
          }
        },
        {
          "id": "place_town",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "place",
          "minzoom": 10,
          "maxzoom": 14,
          "filter": [
            "all",
            ["==", "class", "town"]
          ],
          "layout": {
            "text-anchor": "bottom",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-max-width": 8,
            "text-offset": [0, 0],
            "text-size": {
              "base": 1.2,
              "stops": [
                [7, 12],
                [11, 16],
                [18, 18]
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
          "id": "place_village",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "place",
          "minzoom": 11,
          "maxzoom": 15,
          "filter": [
            "all",
            ["==", "class", "village"]
          ],
          "layout": {
            "text-anchor": "bottom",
            "text-field": "{name}",
            "text-font": ["Roboto Regular"],
            "text-max-width": 8,
            "text-offset": [0, 0],
            "text-size": {
              "base": 1.2,
              "stops": [
                [7, 12],
                [11, 16],
                [18, 18]
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
          "id": "place_other",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "place",
          "minzoom": 13.0,
          "filter": [
            "all",
            [
              "in",
              "class",
              "hamlet",
              "island",
              "islet",
              "neighbourhood",
              "suburb"
            ]
          ],
          "layout": {
            "text-anchor": "bottom",
            "text-field": "{name}",
            "text-font": ["Roboto Condensed Italic"],
            "text-max-width": 8,
            "text-offset": [0, 0],
            "text-size": {
              "base": 1.2,
              "stops": [
                [12, 10],
                [15, 14],
                [18, 16]
              ]
            },
            "text-transform": "uppercase"
          },
          "paint": {
            "text-halo-color": "#fff",
            "text-color": "#212121",
            "text-halo-width": 1
          }
        },
        {
          "id": "poi_symbols",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "poi",
          "minzoom": 13.0,
          "filter": [
            "all",
            ["==", "\$type", "Point"],
            [
              "in",
              "class",
              "park",
              "cemetery",
              "stadium",
              "aerialway",
              "castle"
            ],
            [
              "<=",
              "rank",
              [
                "step",
                ["zoom"],
                60,
                15.0,
                999
              ]
            ]
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
          "id": "road_label_primary_motorway",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "transportation_name",
          "minzoom": 11,
          "filter": [
            "all",
            ["in", "class", "primary", "motorway", "trunk"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": "{name}",
            "visibility": "visible",
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
          "id": "road_label_secondary",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "transportation_name",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "class", "secondary"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": "{name}",
            "visibility": "visible",
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
          "id": "road_label_tertiary",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "transportation_name",
          "minzoom": 13,
          "filter": [
            "all",
            ["in", "class", "tertiary"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": "{name}",
            "visibility": "visible",
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
          "id": "road_label_minor",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "transportation_name",
          "minzoom": 15.0,
          "filter": [
            "all",
            ["in", "class", "minor", "path", "track"]
          ],
          "layout": {
            "symbol-placement": "line",
            "text-field": "{name}",
            "visibility": "visible",
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
          "id": "housenumber",
          "type": "symbol",
          "source": "openmaptiles",
          "source-layer": "housenumber",
          "minzoom": 16.0,
          "filter": [
            "all",
            ["==", "\$type", "Point"]
          ],
          "layout": {
            "text-anchor": "top",
            "text-field": "{housenumber}",
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
        }
      ],
      "id": "multi_light"
    };
